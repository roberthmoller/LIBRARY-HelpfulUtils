/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/method.dart';
import 'package:h_utils/control_flow/optional/optional.dart';
import 'package:h_utils/control_flow/optional/present.dart';
import 'package:h_utils/control_flow/predicate.dart';

import 'optional/empty.dart';

class Switcher<I, O> {
  final Map<Predicate<I>, Method<I, O>> cases;
  final I value;

  Switcher.of(this.value) : cases = Map();

  Switcher<I, O> predicate(final Predicate<I> predicate, final Method<I, O> value) {
    return this..cases.putIfAbsent(predicate, () => value);
  }

  Switcher<I, O> key(final I key, final Method<I, O> value) {
    return this.predicate((value) => value == key, value);
  }

  Optional<O> consume() {
    return cases.entries.fold(empty<O>(), (carry, entry) {
      return carry is Empty<MapEntry> && entry.key(value) // @formatter:off
          ? present(entry).map((match) => match.value(value))
          : carry; // @formatter:on
    });
  }

  O orElse(final O value) {
    return consume().orElseGet(value);
  }
}
