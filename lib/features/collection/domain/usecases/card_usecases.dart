import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/card.dart';
import '../entities/card_filter.dart';
import '../repositories/card_repository.dart';

/// Watch a filtered, reactive list of cards.
class WatchCards {
  const WatchCards(this._repo);
  final CardRepository _repo;
  Stream<List<CardEntity>> call(CardFilter filter) => _repo.watchCards(filter);
}

class GetCardById {
  const GetCardById(this._repo);
  final CardRepository _repo;
  Future<Result<CardEntity>> call(int id) => _repo.getById(id);
}

/// Add a card after validating business rules.
class AddCard {
  const AddCard(this._repo);
  final CardRepository _repo;

  Future<Result<int>> call(CardEntity card) {
    final invalid = _validate(card);
    if (invalid != null) return Future.value(Err(invalid));
    return _repo.add(card);
  }
}

class UpdateCard {
  const UpdateCard(this._repo);
  final CardRepository _repo;

  Future<Result<void>> call(CardEntity card) {
    if (card.id == null) {
      return Future.value(const Err(ValidationFailure('Card has no id.')));
    }
    final invalid = _validate(card);
    if (invalid != null) return Future.value(Err(invalid));
    return _repo.update(card);
  }
}

class DeleteCard {
  const DeleteCard(this._repo);
  final CardRepository _repo;
  Future<Result<void>> call(int id) => _repo.delete(id);
}

class ToggleFavorite {
  const ToggleFavorite(this._repo);
  final CardRepository _repo;
  Future<Result<void>> call(int id) => _repo.toggleFavorite(id);
}

class MarkAsOwned {
  const MarkAsOwned(this._repo);
  final CardRepository _repo;
  Future<Result<void>> call(int id) => _repo.markAsOwned(id);
}

/// Shared validation for add/update. Returns a [ValidationFailure] or null.
ValidationFailure? _validate(CardEntity card) {
  if (card.name.trim().isEmpty) {
    return const ValidationFailure('Card name is required.');
  }
  if (card.quantity < 0) {
    return const ValidationFailure('Quantity cannot be negative.');
  }
  if (card.purchasePrice != null && card.purchasePrice! < 0) {
    return const ValidationFailure('Purchase price cannot be negative.');
  }
  if (card.currentValue != null && card.currentValue! < 0) {
    return const ValidationFailure('Value cannot be negative.');
  }
  return null;
}
