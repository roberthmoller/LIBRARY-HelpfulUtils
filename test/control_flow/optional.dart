/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:h_utils/control_flow/method.dart';

void method() {

  test('\'of\' should return the value independent of input', () {
    expect(Methods.value('foo')(anything), 'foo');
  });

  test('\'format\' should replace \'{}\' in a given string with the result of the method', () {
    expect(Methods.value('bar').format('foo {}')(anything), 'foo bar');
  });

  test('\'forEach\' should iterate over all values in an input list', () {
    int counter = 0;
    final Method<List<int>, void> forEach = Methods.stub.forEach((i) => ++counter);

    forEach(List.generate(10, Methods.passthrough));

    expect(counter, 10);
  });

  test('\'stub\' should take a value but return void', () {
    expect(Methods.stub, isA<void>());
  });

  test('\'value\' should return the given value independent of the input', () {
    Method<dynamic, int> valueMethod = Methods.value(2);
    expect(valueMethod(10), equals(2));
  });

  group('Map', () {
    test('should map the the original output value to a new value using a given mapper', () {
      final Method<String, String> passthrhough = (s) => s;
      final int result = passthrhough.map((string) => string.length)('bar');

      expect(result, 'bar'.length);
    });
  });
}
