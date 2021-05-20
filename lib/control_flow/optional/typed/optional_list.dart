/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import 'package:h_utils/control_flow/optional/tuple/both_present.dart';

import '../optional.dart';
import 'optional_string.dart';

typedef OptionalList<T> = Optional<List<T>>;

OptionalList<T> ofList<T>(final List<T> value) => Optional.of(value);

extension OptionalLists<T> on OptionalList<T> {
  OptionalList<T> operator +(final OptionalList<T> that) {
    return bothPresent<List<T>, List<T>, List<T>>((a, b) => a.followedBy(b).toList())(this, that);
  }

  int get length => this.map((x) => x.length).orElseGet(0);

  OptionalString join([final String separator = ' ']) => this.map((x) => x.join(separator));

  Optional<R> fold<R>(final R initial, final R Function(R, T) reducer) => this.map((x) => x.fold(initial, reducer));

  Optional<T> reduce(final T Function(T, T) reducer) => this.map((x) => x.reduce(reducer));
}
