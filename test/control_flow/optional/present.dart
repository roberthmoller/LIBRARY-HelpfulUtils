/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:h_utils/control_flow/optional/empty.dart';
import 'package:h_utils/control_flow/optional/optional.dart';
import 'package:h_utils/control_flow/optional/present.dart';

void main() {
  group('Present', () {
    group('map', () {
      test('does update the value of a present optional', () {
        expect(present('foo').map((foo) => 'bar'), hasValue('bar'));
      });
      test('does not update the value of a present optional when previously mapped to null', () {
        expect(present('foo').map((foo) => null).map((nil) => 'bar'), isEmpty());
      });
    });
    group('flatMap', () {});
    group('ifPresent', () {});
    group('isPresent', () {});
    group('isEmpty', () {});
    group('orElse', () {});
    group('orElseGet', () {});
    group('orThrow', () {});
  });
}

OptionalHasValueMatcher<T> hasValue<T>(final T value) => OptionalHasValueMatcher<T>(value);

class OptionalHasValueMatcher<T> extends TypeMatcher<Optional<T>> {
  final T value;

  OptionalHasValueMatcher(this.value) : super();

  @override
  bool matches(final Object? item, final Map matchState) => super.matches(item, matchState) && typedMatches(item as Optional<T>, matchState);

  bool typedMatches(final Optional<T> item, final Map matchState) => item.equals(value);
}

OptionalIsEmptyMatcher<T> isEmpty<T>() => OptionalIsEmptyMatcher<T>();

class OptionalIsEmptyMatcher<T> extends TypeMatcher<Empty<T>> {
  OptionalIsEmptyMatcher() : super();

  @override
  bool matches(final Object? item, final Map matchState) => super.matches(item, matchState);
}
