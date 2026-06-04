import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/database_provider.dart';
import '../../data/datasources/tag_local_datasource.dart';
import '../../data/repositories/tag_repository_impl.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/tag_repository.dart';

final tagLocalDataSourceProvider = Provider<TagLocalDataSource>((ref) {
  return TagLocalDataSource(ref.watch(appDatabaseProvider));
});

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  return TagRepositoryImpl(ref.watch(tagLocalDataSourceProvider));
});

/// Reactive list of all tags (with card counts).
final tagsProvider = StreamProvider<List<TagEntity>>((ref) {
  return ref.watch(tagRepositoryProvider).watchTags();
});
