/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../empty.dart';
import '../optional.dart';
import '../present.dart';
import 'optional_tuple.dart';

NeitherPresent<A, B, R> neitherPresent<A, B, R>(final R Function(Optional<A> first, Optional<B> second) mapper) => NeitherPresent<A, B, R>(mapper);

class NeitherPresent<A, B, R> extends OptionalTuple<A, B, R, Optional<A>, Optional<B>> {
  const NeitherPresent(final R Function(Optional<A> first, Optional<B> second) mapper) : super(mapper);

  Optional<R> call(final Optional<A> a, final Optional<B> b) {
    return a is! Present<A> && b is! Present<B> // @formatter:off
        ? of(mapper(a, b))
        : empty(); //@formatter:on
  }
}
