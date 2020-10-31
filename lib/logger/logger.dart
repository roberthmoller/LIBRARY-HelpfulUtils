/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */
import 'package:flutter/foundation.dart';
import 'package:h_utils/control_flow/method.dart';
import 'package:h_utils/control_flow/optional.dart';
import 'package:logger/logger.dart' as Dependency show Logger;
import 'package:logger/logger.dart' hide Logger;

class Logger {
  final Dependency.Logger logger;
  final Type type;

  const Logger(this.type, {@required this.logger});

  factory Logger.pretty(final Type type) {
    return Logger(
      type,
      logger: Dependency.Logger(
        printer: PrettyPrinter(
          colors: false,
          // printTime: true,
          methodCount: 0,
        ),
      ),
    );
  }

  void i(final dynamic content, {final String title}) {
    logger.i('${type.toString()} | $title', content);
  }

  void d(final String title, final dynamic message) {
    logger.d('${type.toString()} | $title', message);
  }

  void w(final String title, final dynamic message, [final dynamic error, final StackTrace stackTrace]) {
    logger.w(content(title: title, message: message), error, stackTrace);
  }

  void v(final String title, final dynamic message, [final dynamic error, final StackTrace stackTrace]) {
    logger.v(content(title: title, message: message), error, stackTrace);
  }

  void e([final dynamic error, final StackTrace stackTrace]) {
    logger.e('${type.toString()} | Error', error, stackTrace);
  }

  void wtf([final dynamic error, final StackTrace stackTrace]) {
    logger.e(type.toString(), error, stackTrace);
  }

  String content({final String title, final String message}) =>
      '[${type.runtimeType.toString()}] ${Optional.of(title).orElseGet("")}${Optional.of(message).map(Methods.format('\n\n{}')).orElseGet("")}';
}

class PrettyLogger<T> {
  final Logger log = Logger.pretty(T);
}
