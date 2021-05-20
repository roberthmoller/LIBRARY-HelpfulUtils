/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */
import 'package:date_format/date_format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:h_utils/date_time/date.dart';

void main() {
	const int YEAR = 365;
	const int MONTH = 31;
	const int WEEK = 7;

	test("isBefore", () {
		bool isBefore = Date.from(DateTime.now().subtract(Duration(days: 1))).isBefore(Date.from(DateTime.now()));
		bool isNotBefore = Date.now().isAfter(Date.now());

		assert(isBefore);
		assert(!isNotBefore);
	});

	test("isAfter", () {
		bool isAfter = Date.from(DateTime.now().add(Duration(days: 1))).isAfter(Date.from(DateTime.now()));
		bool isNotAfter = Date.now().isAfter(Date.now());

		assert(isAfter);
		assert(!isNotAfter);
	});

	test("isNotEqual", () {
		bool isNotEqual = Date.from(DateTime.now().add(Duration(days: 1))) != Date.from(DateTime.now());
		assert(isNotEqual);
	});

	test("isEqual", () {
		bool isEqual = Date.now() == Date.now();
		assert(isEqual);
	});

	test("difference", () {
		Duration difference = Date.from(DateTime.now().add(Duration(days: 1))).difference(Date.from(DateTime.now()));
		assert(difference.inDays == 1);
	});

	test("now", () {
		Date format = Date.now();
		print(format);
		assert(format == Date.from(DateTime.now()));
	});

	test("from", () {
		var now = DateTime.now();
		Date expected = Date.of(day: now.day, month: now.month, year: now.year);
		Date actual = Date.from(now);
		assert(actual == expected, "\nExpected: $actual to equal $expected");
	});

	group('toString', () {
		test('toDMYYYString', () {
			var now = Date.of(day: 1, month: 2, year: 3);
			var dmyyyyString = now.toDMYYYYString();
			var expected = "1/2/3";

			assert(dmyyyyString == expected, 'Expected $dmyyyyString to equal $expected');
		});

		test('toDDMMYYYString', () {
			var now = Date.of(day: 1, month: 2, year: 3);
			var dmyyyyString = now.toDDMMYYYYString();
			var expected = "01/02/0003";

			assert(dmyyyyString == expected, 'Expected $dmyyyyString to equal $expected');
		});
	});



	group('toShortString', () {
		group('Past', () {
			test("Yesterday", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 1))).toShortString();
				var expected = "Yesterday";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("2 days ago", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 2))).toShortString();
				var expected = "2 days ago";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Last week", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: WEEK))).toShortString();
				var expected = "Last week";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("2 weeks ago", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 2 * WEEK))).toShortString();
				var expected = "2 weeks ago";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Last month", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: MONTH))).toShortString();
				var expected = "Last month";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("2 months ago", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 2 * MONTH))).toShortString();
				var expected = "2 months ago";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Last year", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: YEAR))).toShortString();
				var expected = "Last year";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("2 years ago", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 2 * YEAR))).toShortString();
				var expected = "2 years ago";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});
		});

		test('Present', () {
			String actual = Date.now().toShortString();
			var expected = "Today";
			print(actual);

			assert(actual == expected, "\nExpected $actual to equal $expected");
		});

		group('Future', () {
			test("Tomorrow", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 1))).toShortString();
				var expected = "Tomorrow";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In 2 days", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 2))).toShortString();
				var expected = "In 2 days";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Next week", () {
				String actual = Date.from(DateTime.now().add(Duration(days: WEEK))).toShortString();
				var expected = "Next week";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In 2 weeks", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 2 * WEEK))).toShortString();
				var expected = "In 2 weeks";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Next month", () {
				String actual = Date.from(DateTime.now().add(Duration(days: MONTH))).toShortString();
				var expected = "Next month";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In 2 months", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 2 * MONTH))).toShortString();
				var expected = "In 2 months";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("Next year", () {
				String actual = Date.from(DateTime.now().add(Duration(days: YEAR))).toShortString();
				var expected = "Next year";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In 2 years", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 2 * YEAR))).toShortString();
				var expected = "In 2 years";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});
		});
	});

	group('toLongString', () {
		group('Past', () {
			test("Yesterday", () {
				String actual = Date.from(DateTime.now().subtract(Duration(days: 1))).toLongString();
				var expected = "Yesterday";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("2 Days ago", () {
				var dateTime = DateTime.now().subtract(Duration(days: 2));
				String actual = Date.from(dateTime).toLongString();
				var expected = formatDate(dateTime, [DD]);

				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("More than a week ago", () {
				var dateTime = DateTime.now().subtract(Duration(days: WEEK + 1));
				String actual = Date.from(dateTime).toLongString();
				var expected = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});
		});

		test('Present', () {
			String actual = Date.now().toLongString();
			var expected = "Today";
			print(actual);

			assert(actual == expected, "\nExpected $actual to equal $expected");
		});

		group('Future', () {
			test("Tomorrow", () {
				String actual = Date.from(DateTime.now().add(Duration(days: 1))).toLongString();
				var expected = "Tomorrow";
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In 2 days", () {
				var dateTime = DateTime.now().add(Duration(days: 2));
				String actual = Date.from(dateTime).toLongString();
				var expected = formatDate(dateTime, [DD]);
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});

			test("In more than a week", () {
				var dateTime = DateTime.now().add(Duration(days: WEEK + 1));
				String actual = Date.from(dateTime).toLongString();
				var expected = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
				print(actual);

				assert(actual == expected, "\nExpected $actual to equal $expected");
			});
		});
	});
}

