/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

bool listNotEmpty<T>(Iterable<T> x) => notNull(x) && x.isNotEmpty;

bool isEmptyString(String x) => isNull(x) || x.isEmpty;

bool notNull(dynamic x) => x != null;

bool notBlank(String x) => notNull(x) && x.trim().isNotEmpty;

bool notZero(int x) => notNull(x) && x != 0;

bool notNegative(int x) => notNull(x) && x >= 0;

bool notEmpty<T>(Iterable<T> x) => notNull(x) && x.isNotEmpty;

bool listNotNull<T>(List<T> x) => notEmpty(x) && !x.contains(null);

bool isNull(Object x) => x == null;

bool isBlank(String x) => isNull(x) || x.trim().isEmpty;

bool isEmpty<T>(Iterable<T> x) => isNull(x) || x.isEmpty;

bool listIsEmpty<T>(Iterable<T> x) => isNull(x) || x.isEmpty;

bool isZero(int x) => isNull(x) || x == 0;

bool listIsNull<T>(Iterable<T> x) => isEmpty(x) || x.where((y) => y == null).length == x.length;

bool mapIsNull<A, B>(Map<A, B> x) => x.isEmpty || x.containsValue(null);
