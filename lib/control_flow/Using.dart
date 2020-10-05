/*
 * Copyright (c) 2020. Booza <contact@booza.app>
 */

import 'package:h_utils/control_flow/method.dart';
import 'package:h_utils/control_flow/optional.dart';

/// Eager using implementation
class Using<T> {
  final T value;

  const Using(this.value);

  /// Alter the value without mutating the field
  Using<R> map<R>(final R Function(T value) mapper) {
    return Using<R>(mapper(value));
  }

  /// Consume the using to result in a value
  R within<R>(final R Function(T value) mapper) {
    return mapper(value);
  }

  /// Alter the value if provided a present optional
  OptionallyUsing<T> optionally<O>(final T Function(T value) Function(O optional) mapper, final Optional<O> optional) {
    return OptionallyUsing<T>(value, optional.map((opt) => mapper(opt)));
  }

  @deprecated
  Using<T> optionally2<V>(final T Function(T value, V optional) mapper, final Optional<V> optional) {
    return Using<T>(optional.map((opt) => mapper(value, opt)).orElseGet(value));
  }
}

class OptionallyUsing<T> extends Using<T> {
  final Optional<T Function(T value)> optional;

  const OptionallyUsing._(final T value, this.optional) : super(value);

  factory OptionallyUsing(
    final T value,
    final Optional<T Function(T value)> optionalMapper,
  ) {
    return OptionallyUsing._(
      optionalMapper.orElseGet(Methods.passthrough)(value),
      optionalMapper,
    );
  }

  /// Alter the value when provided with an empty optional
  Using<T> orElse(final T Function(T value) mapper) {
    return Using<T>(super.value).map((value) => optional.isPresent ? value : mapper(value));
  }
}
