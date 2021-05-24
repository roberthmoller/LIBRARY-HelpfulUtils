/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/optional/tuple/both_present.dart';
import 'package:h_utils/string.dart';

import '../../conditions.dart' as Conditions;
import '../optional.dart';
import 'optional_list.dart';

typedef OptionalString = Optional<String>;

OptionalString ofString(final String value) => Optional.of(value);

extension OptionalStrings on OptionalString {
  OptionalString operator +(final OptionalString that) {
    return bothPresent<String, String, String>((a, b) => a + b)(this, that);
  }

  OptionalString operator *(final int times) {
    return this.map((value) => List.generate(times, (index) => value).join(EMPTY));
  }

  OptionalString trim() => this.map((x) => x.trim());

  OptionalList<String> split(final Pattern pattern) => this.map((x) => x.split(pattern));

  int get length => this.map((x) => x.length).orElseGet(0);

  bool get isBlank => this.map(Conditions.isBlank).orElseGet(false);

  bool get isNotBlank => this.map(Conditions.notBlank).orElseGet(false);

  OptionalString get whenBlank => this.filter(Conditions.isBlank);

  OptionalString get whenNotBlank => this.filter(Conditions.notBlank);
}
