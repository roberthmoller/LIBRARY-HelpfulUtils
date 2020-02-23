/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/consumer.dart';
import 'package:h_utils/control_flow/supplier.dart';

typedef Method<I, O> = O Function(I);

extension EMethod<I, O> on Method<I, O> {
  Method<I, O2> map<O2>(final Method<O, O2> mapper) {
    return (input) => mapper(this(input));
  }

  Method<I, O> also(final Consumer<I> tap) {
    return (input) {
      tap(input);
      return this(input);
    };
  }

  Method<I, O> tap(final Consumer<I> tap) {
    return also(tap);
  }

  Method<I, String> format(final String value) => map((input) => value.replaceFirst("{}", input.toString()));
}

extension EListMethod<X, O> on Method<List<X>, O> {
  Method<List<X>, O> forEach(final Consumer<X> consumer) => this.tap((l) => l.forEach(consumer));
}

Method<I, O> swap<I, O>(final Method<I, O> mapper) => (i) => mapper(i);

Method<I, O> value<I, O>(final O value) => (_) => value;

Method<I, O> using<I, O>(final Supplier<O> reference) => (_) => reference();

Method<I, void> stub<I, O>() => (i) {};

O passthrough<I, O extends I>(final I value) => value;

Method<dynamic, String> format(final String value) => (input) => value.replaceFirst("{}", input.toString());
//Method<List<dynamic>, String> formatList(final String value) => (input) => value.replaceAllMapped("\${}", (match) => value); // todo: How to replace matches iteratively