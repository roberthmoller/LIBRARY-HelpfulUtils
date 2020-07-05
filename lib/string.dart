/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'dart:math';

import 'package:h_utils/control_flow/supplier.dart';

extension StringExtensions on String {}

extension StringNumExtensions on num {
  String toFixedLengthString(final int length) {
    return Suppliers.of(this.toString())
        .map((string) => string.substring(0, min(string.length, length)))
        .map((string) => string.padLeft(length, '0'))
        .get();
  }
}
