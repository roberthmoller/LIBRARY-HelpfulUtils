/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/method.dart';

typedef Supplier<Value> = Value Function();

class Suppliers {
  static Supplier<T> of<T>(final T t) {
    return () => t;
  }
}

extension SupplierExtensions<T> on Supplier<T> {
  Supplier<U> map<U>(final Method<T, U> mapper) {
    return () => mapper(this());
  }

  T get() {
    return this();
  }
}