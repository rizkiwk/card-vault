import '../error/failures.dart';

/// A lightweight, dependency-free `Either`-style result.
///
/// `Result<T>` is either [Success] (carrying a value) or [Err] (carrying a
/// [Failure]). Keeps the domain layer free of exceptions.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isError => this is Err<T>;

  /// Value if success, otherwise null.
  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        Err<T>() => null,
      };

  /// Failure if error, otherwise null.
  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Err<T>(:final failure) => failure,
      };

  R fold<R>(R Function(Failure failure) onError, R Function(T value) onSuccess) {
    return switch (this) {
      Success<T>(:final value) => onSuccess(value),
      Err<T>(:final failure) => onError(failure),
    };
  }
}

class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}
