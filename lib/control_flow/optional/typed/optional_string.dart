/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/optional/tuple/both_present.dart';
import 'package:h_utils/string.dart';

import '../../conditions.dart' as Conditions;
import '../optional.dart';

typedef OptionalString = Optional<String>;

OptionalString ofString(final String value) => Optional.of(value);

extension OptionalStrings on OptionalString {
  OptionalString operator +(final OptionalString that) {
    return bothPresent<String, String, String>((a, b) => a + b)(this, that);
  }

  OptionalString operator *(final int times) {
    return this.map((value) => List.generate(times, (index) => value).join(EMPTY));
  }

  int get length => this.map((x) => x.length).orElseGet(0);

  bool get isBlank => this.map(Conditions.isBlank).orElseGet(false);

  bool get isNotBlank => this.map(Conditions.notBlank).orElseGet(false);
}
