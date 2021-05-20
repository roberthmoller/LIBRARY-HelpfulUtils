/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../optional.dart';
import '../tuple/both_present.dart';

Optional<num> ofNum(final num number) => Optional.of(number);

typedef OptionalNum = Optional<num>;

Optional<int> ofInt(final int integer) => Optional.of(integer);

typedef OptionalInt = Optional<int>;

Optional<double> ofDouble(final double double) => Optional.of(double);

typedef OptionalDouble = Optional<double>;

extension OptionalNums on OptionalNum {
  OptionalNum operator +(final OptionalNum that) {
    return bothPresent<num, num, num>((a, b) => a + b)(this, that);
  }

  OptionalNum operator *(final OptionalNum that) {
    return bothPresent<num, num, num>((a, b) => a * b)(this, that);
  }

  OptionalNum operator -(final OptionalNum that) {
    return bothPresent<num, num, num>((a, b) => a - b)(this, that);
  }

  OptionalNum operator /(final OptionalNum that) {
    return bothPresent<num, num, num>((a, b) => a / b)(this, that);
  }

  OptionalNum operator ~/(final OptionalNum that) {
    return bothPresent<num, num, num>((a, b) => a ~/ b)(this, that);
  }
}

main() {
  OptionalNum optional = ofInt(6) * ofDouble(.5);
}
