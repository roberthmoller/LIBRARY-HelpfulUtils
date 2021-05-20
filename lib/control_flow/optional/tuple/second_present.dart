/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../empty.dart';
import '../optional.dart';
import '../present.dart';
import 'optional_tuple.dart';

SecondPresent<A, B, R> secondPresent<A, B, R>(final R Function(Optional<A> first, B second) mapper) => SecondPresent<A, B, R>(mapper);

class SecondPresent<A, B, R> extends OptionalTuple<A, B, R, Optional<A>, B> {
  const SecondPresent(final R Function(Optional<A> first, B second) mapper) : super(mapper);

  Optional<R> call(final Optional<A> a, final Optional<B> b) {
    return b is Present<B> // @formatter:off
        ? of(mapper(a, b.value))
        : empty(); //@formatter:on
  }
}
