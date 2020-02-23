/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:equatable/equatable.dart';
import 'package:h_utils/control_flow/conditions.dart';

class Optional<TYPE> extends Equatable {
  final TYPE _value;

  Optional.of(TYPE value) : this._value = value;

  Optional.condition(bool condition, TYPE value) : this._value = (condition ? value : null);

  Optional.empty() : this._value = null;

  factory Optional.run(TYPE Function() action) {
    try {
      return Optional.of(action());
    } catch (exception) {
      // Log exception
      return Optional.empty();
    }
  }

  bool equals(TYPE value) {
    return _value == value;
  }

  bool get isPresent => notNull(value);

  TYPE get value => _value;

  Optional<TYPE> ifPresent(final void Function(TYPE) action) {
    if (isPresent) action(value);
    return this;
  }

  Optional<NEWTYPE> flatMap<NEWTYPE>(final Optional<NEWTYPE> Function(TYPE) mapper) {
    if (isPresent) {
      var newValue = mapper(value);
      if (notNull(newValue)) return newValue;
    }
    return Optional<NEWTYPE>.empty();
  }

  Optional<NEWTYPE> map<NEWTYPE>(final NEWTYPE Function(TYPE) mapper) {
    if (isPresent) {
      var newValue = mapper(value);
      if (notNull(newValue)) return Optional.of(newValue);
    }
    return Optional<NEWTYPE>.empty();
  }

  Optional<TYPE> changeIf(final bool Function(Optional<TYPE>) condition, final Optional<TYPE> Function(Optional<TYPE>) mapper) {
    if (condition(this)) {
      return mapper(this);
    }
    return Optional<TYPE>.empty();
  }

  Optional<TYPE> run(void Function(Optional<TYPE>) action) {
    action(this);
    return this;
  }

  Optional<TYPE> apply(void Function(TYPE) action) {
    if (isPresent) action(this.value);
    return this;
  }

  TYPE orElse(TYPE Function() action) {
    if (isPresent) return value;
    return action();
  }

  TYPE orElseGet(TYPE newValue) {
    if (isPresent) return value;
    return newValue;
  }

  TYPE orThrow(Exception exception) {
    if (isPresent) return value;
    throw exception;
  }

  TYPE get() => value;

  @override
  String toString() {
    return 'Optional{${isPresent ? 'value: $_value' : 'empty'}}';
  }

  @override
  List<Object> get props => [value];

//  @override
//  bool operator ==(Object other) =>
//      identical(this, other) ||
//          other is Optional && runtimeType == other.runtimeType && _value == other._value;

//  @override
//  int get hashCode => _value.hashCode;
}
