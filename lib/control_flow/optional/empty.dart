/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import '../functional.dart';
import '../predicate.dart';
import 'optional.dart';

Empty<T> empty<T>() => Empty<T>();

class Empty<T> extends Optional<T> {
  const Empty() : super();

  T orElse(final T Function() supplier) => supplier();

  T orElseGet(final T value) => value;

  T orThrow(final Exception exception) => throw exception;

  bool equals(T value) => false;

  bool get isPresent => false;

  Empty<N> conditionally<N>(final bool Function(Optional<T>) _, final Optional<N> Function(Optional<T>) __) => empty();

  Empty<N> map<N>(final N Function(T) _) => Empty();

  Empty<N> flatMap<N>(final Optional<N> Function(T) _) => Empty();

  Empty<T> filter(final Predicate<T> _) => this;

  Empty<T> ifPresent(void Function(T) _) => this;

  Empty<T> ifEmpty(final void Function() action) => this.execute(action);

  Empty<T> run(final void Function(Empty<T>) action) => this.also(action);

  String toString() => 'Empty { }';

  List<Object> get props => [];
}
