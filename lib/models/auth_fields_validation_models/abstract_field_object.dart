import 'package:dartz/dartz.dart';

abstract class AbstractFieldObject<T> {
  const AbstractFieldObject();
  Either<T, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold(
        (f) =>
            throw "Failure at an unrecoverable point. reason is ${f.toString()} ",
        id);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AbstractFieldObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
