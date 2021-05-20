/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */


import '../optional.dart';

abstract class OptionalTuple<A, B, R, X, Y> {
  final R Function(X first, Y second) mapper;

  const OptionalTuple(this.mapper);

  Optional<R> call(final Optional<A> a, final Optional<B> b);
}



