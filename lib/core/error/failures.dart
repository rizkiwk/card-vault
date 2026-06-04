/// Base type for all recoverable, user-facing errors.
///
/// Exceptions are caught in the data layer and converted to a [Failure],
/// so nothing above the repository ever has to `try/catch`.
sealed class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'A database error occurred.']);
}

class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Could not save the file.']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission was denied.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Item not found.']);
}
