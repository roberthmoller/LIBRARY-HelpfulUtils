/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */


import 'method.dart';

extension FunctionalFlow<T> on T {
  T also(final Method<T, void> e) {
    e(this);
    return this;
  }

  T execute(final void Function() e) {
    e();
    return this;
  }
}
