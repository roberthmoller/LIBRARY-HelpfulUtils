/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../empty.dart';
import '../optional.dart';
import '../present.dart';
import 'optional_tuple.dart';

FirstPresent<A, B, R> firstPresent<A, B, R>(final R Function(A first, Optional<B> second) mapper) => FirstPresent<A, B, R>(mapper);

class FirstPresent<A, B, R> extends OptionalTuple<A, B, R, A, Optional<B>> {
  const FirstPresent(final R Function(A first, Optional<B> second) mapper) : super(mapper);

  Optional<R> call(final Optional<A> a, final Optional<B> b) {
    return a is Present<A> // @formatter:off
        ? of(mapper(a.value, b))
        : empty(); //@formatter:on
  }
}
