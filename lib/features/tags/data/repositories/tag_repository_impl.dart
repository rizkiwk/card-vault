import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../datasources/tag_local_datasource.dart';

class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl(this._ds);
  final TagLocalDataSource _ds;

  @override
  Stream<List<TagEntity>> watchTags() {
    return _ds.watchTagsWithCounts().map(
          (rows) => rows
              .map(
                (r) => TagEntity(
                  id: r.tag.id,
                  name: r.tag.name,
                  color: r.tag.color,
                  cardCount: r.count,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<Result<int>> create(String name, {String? color}) async {
    try {
      final id = await _ds.insert(name, color);
      return Success(id);
    } catch (e) {
      // UNIQUE constraint → duplicate name.
      return const Err(
        ValidationFailure('A tag with that name already exists.'),
      );
    }
  }

  @override
  Future<Result<void>> rename(int id, String name) async {
    try {
      await _ds.rename(id, name);
      return const Success(null);
    } catch (e) {
      return const Err(
        ValidationFailure('A tag with that name already exists.'),
      );
    }
  }

  @override
  Future<Result<void>> setColor(int id, String color) async {
    try {
      await _ds.setColor(id, color);
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await _ds.delete(id);
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }
}
