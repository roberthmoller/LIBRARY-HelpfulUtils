/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:h_utils/control_flow/optional/optional.dart';
import 'package:h_utils/control_flow/optional/present.dart';

void main() {
  group('Optional', () {
    group('map', () {
      test('does update the value of a present optional', () {
        // present('foo').map((p0) => 'bar').val;
      });
      test('does not update the value of a present optional', () {});
    });
    group('flatMap', () {});
    group('ifPresent', () {});
    group('isPresent', () {});
    group('orElse', () {});
    group('orElseGet', () {});
    group('orThrow', () {});
  });
}
