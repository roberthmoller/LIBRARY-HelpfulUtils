/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'dart:math';

import 'package:h_utils/control_flow/supplier.dart';

extension EString on String {}

extension ENum on num {
  String toFixedLengthString(final int length) {
    return of(this.toString()).map((string) => string.substring(0, min(string.length, length))).map((string) => string.padLeft(length, '0'))();
  }
}
