/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import '../functional.dart';
import '../predicate.dart';
import 'empty.dart';
import 'optional.dart';

Present<T> present<T>(final T value) => Present<T>(value);

class Present<T> extends Optional<T> {
  final T value;

  const Present(this.value) : super();

  T orElse(final T Function() ignored) => value;

  T orElseGet(final T ignored) => value;

  T orThrow(final Exception ignored) => value;

  bool equals(final T value) => value == this.value;

  bool get isPresent => true;

  bool get isNotPresent => false;

  Optional<N> map<N>(final N Function(T) mapper) => Optional.of(mapper(value));

  Optional<N> flatMap<N>(final Optional<N> Function(T) mapper) => mapper(value);

  Optional<T> filter(final Predicate<T> predicate) {
    return predicate(value) ? this : Empty();
  }

  Optional<N> conditionally<N>(final bool Function(Optional<T>) condition, final Optional<N> Function(Optional<T>) mapper) {
    return condition(this) ? mapper(this) : empty();
  }

  Present<T> ifPresent(final void Function(T value) action) => this..value.also(action);

  Present<T> ifEmpty(final void Function() _) => this;

  Present<T> run(final void Function(Present<T>) action) => this.also(action);

  String toString() => 'Present { value: $value }';

  List<dynamic> get props => [value];
}
