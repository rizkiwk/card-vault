import '../../../../core/utils/result.dart';
import '../entities/tag.dart';

abstract interface class TagRepository {
  /// Reactive list of all tags (with card counts).
  Stream<List<TagEntity>> watchTags();

  /// Creates a tag; returns its new id. Fails if the name already exists.
  Future<Result<int>> create(String name, {String? color});

  Future<Result<void>> rename(int id, String name);

  Future<Result<void>> setColor(int id, String color);

  /// Deletes a tag; `card_tags` rows cascade away.
  Future<Result<void>> delete(int id);
}
