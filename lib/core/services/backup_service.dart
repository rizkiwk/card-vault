import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';

/// Produces and consumes a single `.cardvault` zip archive containing
/// `data.json` (the full collection) plus every referenced image file.
class BackupService {
  BackupService(this._ds);
  final SettingsLocalDataSource _ds;

  static const _jsonEntry = 'data.json';
  static const _imagesPrefix = 'images/';

  /// Exports the whole collection to a zip file in the temp dir and returns
  /// its path (caller can then share it).
  Future<String> export() async {
    final data = await _ds.exportData();
    final encoder = ZipFileEncoder();
    final tmp = await getTemporaryDirectory();
    final outPath = p.join(
      tmp.path,
      'cardvault_backup_${DateTime.now().millisecondsSinceEpoch}.cardvault',
    );
    encoder.create(outPath);

    // Add the JSON manifest.
    final jsonBytes = utf8.encode(jsonEncode(data));
    encoder
        .addArchiveFile(ArchiveFile(_jsonEntry, jsonBytes.length, jsonBytes));

    // Add each image file under images/<basename>.
    for (final img in (data['images'] as List)) {
      final path = img['filePath'] as String;
      final file = File(path);
      if (file.existsSync()) {
        encoder.addFile(file, '$_imagesPrefix${p.basename(path)}');
      }
    }
    encoder.close();
    return outPath;
  }

  /// Imports a `.cardvault` archive, extracting images into app storage and
  /// rewriting paths, then replacing the current collection.
  Future<void> import(String archivePath) async {
    final bytes = File(archivePath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    // 1. Read manifest.
    final jsonFile = archive.findFile(_jsonEntry);
    if (jsonFile == null) {
      throw const FormatException('Invalid backup: data.json missing.');
    }
    final data = jsonDecode(utf8.decode(jsonFile.content as List<int>))
        as Map<String, dynamic>;

    // 2. Extract images into app storage, building a path remap.
    final docs = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(docs.path, AppConstants.imagesDir));
    if (!imagesDir.existsSync()) imagesDir.createSync(recursive: true);

    final remap = <String, String>{};
    for (final img in (data['images'] as List? ?? [])) {
      final original = img['filePath'] as String;
      final entry = archive.findFile('$_imagesPrefix${p.basename(original)}');
      if (entry == null) continue;
      final dest = p.join(imagesDir.path, p.basename(original));
      File(dest).writeAsBytesSync(entry.content as List<int>);
      remap[original] = dest;
    }

    // 3. Replace DB content.
    await _ds.importData(data, pathRemap: remap);
  }
}
