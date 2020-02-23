/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/method.dart';

extension Math<I extends num, O extends num> on Method<I, O> {
  static Method<I, O> abs(final Method<I, O> m) {
    return (input) => m(input.abs());
  }
}
