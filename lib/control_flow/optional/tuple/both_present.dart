/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../empty.dart';
import '../optional.dart';
import '../present.dart';
import 'optional_tuple.dart';

BothPresent<A, B, R> bothPresent<A, B, R>(final R Function(A first, B second) mapper) => BothPresent<A, B, R>(mapper);

class BothPresent<A, B, R> extends OptionalTuple<A, B, R, A, B> {
  const BothPresent(final R Function(A first, B second) mapper) : super(mapper);

  Optional<R> call(final Optional<A> a, final Optional<B> b) {
    return a is Present<A> && b is Present<B> // @formatter:off
        ? of(mapper(a.value, b.value))
        : empty(); //@formatter:on
  }
}
