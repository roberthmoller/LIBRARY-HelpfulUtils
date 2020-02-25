/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:h_utils/control_flow/method.dart';

typedef Supplier<Value> = Value Function();

Supplier<I> of<I>(final I value) => () => value;

extension ESupplier<R> on Supplier<R> {
	Supplier<R2> map<R2>(final Method<R,R2> mapper) {
		return () => mapper(this());
	}
}