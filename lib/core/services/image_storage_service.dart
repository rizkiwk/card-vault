import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';

/// Result of persisting an image: the full (compressed) file and its thumbnail.
class StoredImage {
  const StoredImage({required this.filePath, required this.thumbPath});
  final String filePath;
  final String thumbPath;
}

/// Arguments passed to the background isolate for resizing.
class _ResizeArgs {
  const _ResizeArgs(this.bytes, this.fullPath, this.thumbPath);
  final Uint8List bytes;
  final String fullPath;
  final String thumbPath;
}

/// Copies picked/captured images into app-private storage, compressing the
/// full image (≤ maxImageDimension, JPEG q85) and generating a 256px thumbnail.
class ImageStorageService {
  ImageStorageService();
  static const _uuid = Uuid();

  Future<Directory> _dir(String sub) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, AppConstants.imagesDir, sub));
    if (!dir.existsSync()) await dir.create(recursive: true);
    return dir;
  }

  /// Persists [sourcePath] (a temp file from image_picker). Returns the stored
  /// full + thumbnail paths. Heavy work runs off the UI isolate.
  Future<StoredImage> persist(String sourcePath) async {
    final fullDir = await _dir('full');
    final thumbDir = await _dir('thumb');
    final id = _uuid.v4();
    final fullPath = p.join(fullDir.path, '$id.jpg');
    final thumbPath = p.join(thumbDir.path, '$id.jpg');

    final bytes = await File(sourcePath).readAsBytes();
    await compute(_resizeAndWrite, _ResizeArgs(bytes, fullPath, thumbPath));

    return StoredImage(filePath: fullPath, thumbPath: thumbPath);
  }

  /// Deletes image files (full + thumb). Silently ignores missing files.
  Future<void> deleteFiles(Iterable<String> paths) async {
    for (final path in paths) {
      for (final candidate in [path, thumbPathFor(path)]) {
        final file = File(candidate);
        if (file.existsSync()) {
          try {
            await file.delete();
          } catch (_) {/* best-effort */}
        }
      }
    }
  }

  /// Derives the thumbnail path from a full image path by convention
  /// (`.../full/<id>.jpg` → `.../thumb/<id>.jpg`).
  static String thumbPathFor(String fullPath) {
    final name = p.basename(fullPath);
    final thumbDir = p.join(p.dirname(p.dirname(fullPath)), 'thumb');
    return p.join(thumbDir, name);
  }
}

/// Top-level so it can run in a background isolate via `compute`.
void _resizeAndWrite(_ResizeArgs args) {
  final decoded = img.decodeImage(args.bytes);
  if (decoded == null) {
    // Not a decodable image — fall back to writing the raw bytes.
    File(args.fullPath).writeAsBytesSync(args.bytes);
    File(args.thumbPath).writeAsBytesSync(args.bytes);
    return;
  }

  final full = decoded.width > AppConstants.maxImageDimension ||
          decoded.height > AppConstants.maxImageDimension
      ? img.copyResize(
          decoded,
          width: decoded.width >= decoded.height
              ? AppConstants.maxImageDimension
              : null,
          height: decoded.height > decoded.width
              ? AppConstants.maxImageDimension
              : null,
        )
      : decoded;
  File(args.fullPath).writeAsBytesSync(img.encodeJpg(full, quality: 85));

  final thumb = img.copyResize(
    decoded,
    width: decoded.width >= decoded.height
        ? AppConstants.thumbnailDimension
        : null,
    height: decoded.height > decoded.width
        ? AppConstants.thumbnailDimension
        : null,
  );
  File(args.thumbPath).writeAsBytesSync(img.encodeJpg(thumb, quality: 80));
}
