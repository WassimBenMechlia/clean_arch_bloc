sealed class Either<L, R> {
  const Either();

  factory Either.left(L l) => Left(l);
  factory Either.right(R r) => Right(r);

  T fold<T>(T Function(L) left, T Function(R) right) => switch (this) {
        Left(:final value) => left(value),
        Right(:final value) => right(value),
      };

  bool isLeft() => this is Left<L, R>;
  bool isRight() => this is Right<L, R>;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Either<L, R> &&
          runtimeType == other.runtimeType &&
          fold((l) => l == (other as Left<L, R>).value,
              (r) => r == (other as Right<L, R>).value);

  @override
  int get hashCode => fold((l) => l.hashCode, (r) => r.hashCode);
}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);

  L get value => _l;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Left<L, R> && runtimeType == other.runtimeType && _l == other._l;

  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);

  R get value => _r;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Right<L, R> &&
          runtimeType == other.runtimeType &&
          _r == other._r;

  @override
  int get hashCode => _r.hashCode;
}
