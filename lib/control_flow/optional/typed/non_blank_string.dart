/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import 'package:h_utils/control_flow/conditions.dart';
import 'package:h_utils/control_flow/optional/present.dart';

import '../empty.dart';
import '../optional.dart';

class NonBlankString {
  static Optional<String> of(final String value) {
    return notBlank(value) // @formatter:off
        ? present(value)
       : empty<String>(); // @formatter:on
  }
}
