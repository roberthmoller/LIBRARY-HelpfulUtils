/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:equatable/equatable.dart';
import 'package:h_utils/control_flow/conditions.dart';
import 'package:h_utils/control_flow/predicate.dart';

class Optional<T> extends Equatable {
  final T _value;

  const Optional.of(T value) : this._value = value;

  const Optional.condition(bool condition, T value) : this._value = (condition ? value : null);

  const Optional.empty() : this._value = null;

  factory Optional.run(T Function() action) {
    try {
      return Optional.of(action());
    } catch (exception) {
      return Optional.empty();
    }
  }

  bool equals(T value) {
    return _value == value;
  }

  bool get isPresent => notNull(value);

  T get value => _value;

  Optional<T> ifPresent(final void Function(T) action) {
    if (isPresent) action(value);
    return this;
  }

  Optional<NEWTYPE> flatMap<NEWTYPE>(final Optional<NEWTYPE> Function(T) mapper) {
    if (isPresent) {
      var newValue = mapper(value);
      if (notNull(newValue)) return newValue;
    }
    return Optional<NEWTYPE>.empty();
  }

  Optional<N> map<N>(final N Function(T) mapper) {
    if (isPresent) {
      var newValue = mapper(value);
      if (notNull(newValue)) return Optional.of(newValue);
    }
    return Optional<N>.empty();
  }

  Optional<T> changeIf(final bool Function(Optional<T>) condition, final Optional<T> Function(Optional<T>) mapper) {
    if (condition(this)) {
      return mapper(this);
    }
    return Optional<T>.empty();
  }

  Optional<T> run(void Function(Optional<T>) action) {
    action(this);
    return this;
  }

  Optional<T> apply(void Function(T) action) {
    if (isPresent) action(this.value);
    return this;
  }

  T orElse(T Function() action) {
    if (isPresent) return value;
    return action();
  }

  T orElseGet(T newValue) {
    if (isPresent) return value;
    return newValue;
  }

  T orThrow(Exception exception) {
    if (isPresent) return value;
    throw exception;
  }

  T get() => value;

  @override
  String toString() {
    return 'Optional{${isPresent ? 'value: $_value' : 'empty'}}';
  }

  @override
  List<Object> get props => [value];

  Set<T> toSet() {
    return map((t) => {t}).orElseGet({});
  }

  Optional<T> filter(final Predicate<T> predicate) {
    return flatMap((T t) => predicate(t) ? Optional.of(t) : Optional.empty());
  }
}
