import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/tag.dart';
import '../repositories/tag_repository.dart';

class WatchTags {
  const WatchTags(this._repo);
  final TagRepository _repo;
  Stream<List<TagEntity>> call() => _repo.watchTags();
}

class CreateTag {
  const CreateTag(this._repo);
  final TagRepository _repo;

  Future<Result<int>> call(String name, {String? color}) {
    if (name.trim().isEmpty) {
      return Future.value(const Err(ValidationFailure('Tag name is required.')));
    }
    return _repo.create(name.trim(), color: color);
  }
}

class RenameTag {
  const RenameTag(this._repo);
  final TagRepository _repo;
  Future<Result<void>> call(int id, String name) {
    if (name.trim().isEmpty) {
      return Future.value(const Err(ValidationFailure('Tag name is required.')));
    }
    return _repo.rename(id, name.trim());
  }
}

class DeleteTag {
  const DeleteTag(this._repo);
  final TagRepository _repo;
  Future<Result<void>> call(int id) => _repo.delete(id);
}

class SetTagColor {
  const SetTagColor(this._repo);
  final TagRepository _repo;
  Future<Result<void>> call(int id, String color) => _repo.setColor(id, color);
}
