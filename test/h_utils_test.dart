import 'package:flutter_test/flutter_test.dart';

import 'control_flow/method.dart' as method;
import 'control_flow/try.dart' as Try;
import 'date_time/date.dart' as date;

void main() {
	group('Method', method.main);
  group('Date', date.main);
  group('Try', Try.main);
}
