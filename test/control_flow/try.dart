import 'package:flutter_test/flutter_test.dart';
import 'package:h_utils/control_flow/try.dart';

void tryTest() {
  test('recovers executions with no value', () {
    Try.run(() => throw TestException1()).recover<TestException1>((e) => 'dolorem ipsum').get();
  });

  test('throws uncaught exceptions', () {
    final Exception exception = TestException1();
    try {
      Try.run(() => throw exception).get();
    } on TestException1 catch (actualException) {
      expect(actualException, exception);
    } catch (unrecognisedException) {
      fail('Did not recognise \'$unrecognisedException\'');
    }
  });

  test('catches execution run', () {
    Try.run(() => throw TestException1()).recover<TestException1>((e) => 'dolorem ipsum').recover<TestException2>((e) => 'foo bar').get();
  });

  test('recover sets a result value', () {
    final String s =
        Try.of<String>(() => throw TestException1()).recover<TestException1>((e) => 'dolorem ipsum').recover<TestException2>((e) => 'foo bar').get();
    expect(s, 'dolorem ipsum');
  });

  test('gets result', () {
    final String s = Try.of(() => 'dolorem ipsum').get();
    expect(s, 'dolorem ipsum');
  });

  test('maps result to a new value', () {
    final String s = Try.of(() => 'dolorem ipsum').map((_) => 'foo bar').get();
    expect(s, 'foo bar');
  });

  test('maps result to a new value and can then recover exceptions to that type', () {
    final int s = Try.of(() => 'dolorem ipsum').map<int>((_) => throw TestException2()).recover<TestException2>((e) => 2).get();
    expect(s, 2);
  });
}

class TestException1 implements Exception {}

class TestException2 implements Exception {}
