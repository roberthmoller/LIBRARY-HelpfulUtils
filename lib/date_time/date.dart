/*
 * Copyright (c) 2020 Robert Hjortsholm Møller
 */

import 'package:date_format/date_format.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:h_utils/control_flow/method.dart';
import 'package:h_utils/control_flow/switcher.dart';

@immutable
class Date extends Equatable {
  static const int WEEK = 7;
  static const double MONTH = 30.1;
  static const int YEAR = 365;

  final int day;
  final int month;
  final int year;

  Date.of({this.day, this.month, this.year});

  factory Date.now() {
    return Date.from(DateTime.now());
  }

  Date.from(final DateTime dateTime)
      : day = dateTime.day,
        month = dateTime.month,
        year = dateTime.year;

  bool isBefore(final Date that) {
    return (this.day < that.day && this.month <= that.month && this.year <= that.year) ||
        (this.month < that.month && this.year <= that.year) ||
        (this.year < that.year);
  }

  bool isAfter(final Date that) {
    return (this.day > that.day && this.month >= that.month && this.year >= that.year) ||
        (this.month > that.month && this.year >= that.year) ||
        (this.year > that.year);
  }

  Duration difference(final Date that) {
    return this.toDateTime().difference(that.toDateTime());
  }

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }

  static int daysToYears(final int days) {
    return days ~/ YEAR;
  }

  static int daysToMonths(final int days) {
    return days ~/ MONTH;
  }

  static int daysToWeeks(final int days) {
    return days ~/ WEEK;
  }

  String toLongString() {
    return Switcher.of(this.difference(Date.now()))
        .predicate((diff) => diff.inDays.abs() > WEEK, using(toDMYYYYString))
        .predicate((diff) => diff.inDays.abs() > 1, value(formatDate(this.toDateTime(), [DD])))
        .key(Duration(days: -1), value('Yesterday'))
        .key(Duration(days: 1), value('Tomorrow'))
        .orElse('Today');
  }

  String toShortString() {
    return Switcher.of(this.difference(Date.now()))
        .predicate((diff) => daysToYears(diff.inDays) < -1, absDays(daysToYears).format("{} years ago"))
        .predicate((diff) => daysToYears(diff.inDays) > 1, absDays(daysToYears).format("In {} years"))
        .predicate((diff) => daysToYears(diff.inDays) == -1, value("Last year"))
        .predicate((diff) => daysToYears(diff.inDays) == 1, value("Next year"))
        .predicate((diff) => daysToMonths(diff.inDays) < -1, absDays(daysToMonths).format("{} months ago"))
        .predicate((diff) => daysToMonths(diff.inDays) > 1, absDays(daysToMonths).format("In {} months"))
        .predicate((diff) => daysToMonths(diff.inDays) == -1, value("Last month"))
        .predicate((diff) => daysToMonths(diff.inDays) == 1, value("Next month"))
        .predicate((diff) => daysToWeeks(diff.inDays) < -1, absDays(daysToWeeks).format("{} weeks ago"))
        .predicate((diff) => daysToWeeks(diff.inDays) > 1, absDays(daysToWeeks).format("In {} weeks"))
        .predicate((diff) => daysToWeeks(diff.inDays) == -1, value("Last week"))
        .predicate((diff) => daysToWeeks(diff.inDays) == 1, value("Next week"))
        .predicate((diff) => diff.inDays < -1, absDays(passthrough).format("{} days ago"))
        .predicate((diff) => diff.inDays > 1, absDays(passthrough).format("In {} days"))
        .key(Duration(days: -1), value('Yesterday'))
        .key(Duration(days: 1), value('Tomorrow'))
        .orElse('Today');
  }

  Method<Duration, int> absDays(final Method<int, int> m) => swap((diff) => m(diff.inDays).abs());

  String toDMYYYYString() {
    return "$day/$month/$year";
  }

  String toDDMMYYYYString() {
    String padLeft(final int value, final int padding) {
      return value.toString().padLeft(padding, '0');
    }

    return "${padLeft(day, 2)}/${padLeft(month, 2)}/${padLeft(year, 4)}";
  }

  @override
  String toString() {
    return 'Date{day: $day, month: $month, year: $year}';
  }

  @override
  List<Object> get props => [year, month, day];
}
