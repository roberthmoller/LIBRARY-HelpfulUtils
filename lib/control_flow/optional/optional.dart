/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:equatable/equatable.dart';
import 'package:h_utils/control_flow/predicate.dart';
import 'package:h_utils/control_flow/supplier.dart';

import 'empty.dart';
import 'present.dart';

export 'typed/optional_list.dart';
export 'typed/optional_num.dart';
export 'typed/optional_string.dart';

Optional<T> of<T>(final T value) => Optional.of(value);

abstract class Optional<T> extends Equatable {
  static Optional<T> of<T>(final T? value) {
    return value != null ? Present(value) : Empty();
  }

  static Empty<T> empty<T>() => const Empty();

  const Optional();

  @deprecated
  T? get value;

  T orElse(final Supplier<T> supplier);

  T orElseGet(final T value);

  T orThrow(final Exception exception);

  bool equals(T value);

  bool get isPresent => this is Present<T>;

  bool get isEmpty => this is Empty<T>;

  Optional<T> ifPresent(final void Function(T) action);

  Optional<T> ifEmpty(final void Function() ignored);

  Optional<T> run(void Function(Optional<T>) action);

  Optional<N> map<N>(final N Function(T) mapper);

  Optional<N> flatMap<N>(final Optional<N> Function(T) mapper);

  Optional<T> filter(final Predicate<T> predicate);

  Set<T> toSet() => map((t) => {t}).orElseGet({});

  List<T> toList() => map((t) => [t]).orElseGet([]);

  Optional<N> conditionally<N>(final bool Function(Optional<T>) condition, final Optional<N> Function(Optional<T>) mapper);

  Optional<N> optionally<X, N>(final Optional<X> optional, final Optional<N> Function(Optional<T>, Optional<X>) optionalTuple) {
    return optionalTuple(this, optional);
  }

  @deprecated
  Present<T> asPresent() => this as Present<T>;

  @deprecated
  Empty<T> asEmpty() => this as Empty<T>;
}

Optional<B> Function(Optional<A>) map<A, B>(final B Function(A p1) mapper) {
  return (a) => a.map(mapper);
}

Optional<B> Function(Optional<A>) flatMap<A, B>(final Optional<B> Function(A p1) flatMapper) {
  return (a) => a.flatMap(flatMapper);
}

Optional<A> Function(Optional<A>) filter<A, B>(final Predicate<A> filter) {
  return (a) => a.filter(filter);
}
