/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

import 'package:equatable/equatable.dart';
import 'package:h_utils/control_flow/conditions.dart';
import 'package:h_utils/control_flow/predicate.dart';
import 'package:h_utils/control_flow/supplier.dart';

// abstract class Optional<T> extends Equatable {
//   final T _value;
//
//   const Optional.of(T value) : this._value = value;
//
//   const Optional.condition(bool condition, T value) : this._value = (condition ? value : null);
//
//   const Optional.empty() : this._value = null;
//
//   factory Optional.run(T Function() action) {
//     try {
//       return Optional.of(action());
//     } catch (exception) {
//       return Optional.empty();
//     }
//   }
//
//   bool equals(T value) {
//     return _value == value;
//   }
//
//   bool get isPresent => notNull(value);
//
//   T get value => _value;
//
//   Optional<T> ifPresent(final void Function(T) action) {
//     if (isPresent) action(value);
//     return this;
//   }
//
//   Optional<NEWTYPE> flatMap<NEWTYPE>(final Optional<NEWTYPE> Function(T) mapper) {
//     if (isPresent) {
//       var newValue = mapper(value);
//       if (notNull(newValue)) return newValue;
//     }
//     return Optional<NEWTYPE>.empty();
//   }
//
//   Optional<N> map<N>(final N Function(T) mapper) {
//     if (isPresent) {
//       var newValue = mapper(value);
//       if (notNull(newValue)) return Optional.of(newValue);
//     }
//     return Optional<N>.empty();
//   }
//
//   Optional<T> changeIf(final bool Function(Optional<T>) condition, final Optional<T> Function(Optional<T>) mapper) {
//     if (condition(this)) {
//       return mapper(this);
//     }
//     return Optional<T>.empty();
//   }
//
//   Optional<T> run(void Function(Optional<T>) action) {
//     action(this);
//     return this;
//   }
//
//   Optional<T> apply(void Function(T) action) {
//     if (isPresent) action(this.value);
//     return this;
//   }
//
//   T orElse(T Function() action) {
//     if (isPresent) return value;
//     return action();
//   }
//
//   T orElseGet(T newValue) {
//     if (isPresent) return value;
//     return newValue;
//   }
//
//   T orThrow(Exception exception) {
//     if (isPresent) return value;
//     throw exception;
//   }
//
//   T get() => value;
//
//   @override
//   String toString() {
//     return 'Optional{${isPresent ? 'value: $_value' : 'empty'}}';
//   }
//
//   @override
//   List<Object> get props => [value];
//
//   Set<T> toSet() {
//     return map((t) => {t}).orElseGet({});
//   }
//
//   Optional<T> filter(final Predicate<T> predicate) {
//     return flatMap((T t) => predicate(t) ? Optional.of(t) : Optional.empty());
//   }
// }

Empty<T> empty<T>() => Empty<T>();

Present<T> present<T>(final T value) => Present<T>(value);

Optional of<T>(final T value) => Optional.of(value);

abstract class Optional<T> extends Equatable {
  const Optional();

  // const Optional.condition(bool condition, T value) : this._value = (condition ? value : null);

  // const Optional.empty() : this._value = null;

  // factory Optional.run(T Function() action) {
  //   try {
  //     return Optional.of(action());
  //   } catch (exception) {
  //     return Optional.empty();
  //   }
  // }

  // bool equals(T value) {
  //   return _value == value;
  // }

  // bool get isPresent => notNull(value);
  bool equals(T value);

  bool get isPresent;

  Optional<T> ifPresent(final void Function(T) action);

  // Optional<T> ifPresent(final void Function(T) action) {
  //   if (isPresent) action(value);
  //   return this;
  // }

  // Optional<T> changeIf(final bool Function(Optional<T>) condition, final Optional<T> Function(Optional<T>) mapper) {
  //   if (condition(this)) {
  //     return mapper(this);
  //   }
  //   return Optional<T>.empty();
  // }

  // Optional<T> run(void Function(Optional<T>) action) {
  //   action(this);
  //   return this;
  // }

  // Optional<T> apply(void Function(T) action) {
  //   if (isPresent) action(this.value);
  //   return this;
  // }
  //

  Optional<N> map<N>(final N Function(T) mapper);

  Optional<N> flatMap<N>(final Optional<N> Function(T) mapper);

  Optional<T> filter(final Predicate<T> predicate);

  T orElse(final Supplier<T> supplier);

  T orElseGet(final T value);

  T orThrow(final Exception exception);

  static Optional<T> of<T>(final T value) {
    if (notNull(value)) return Present(value);
    return Empty();
  }

  static const Empty empty = const Empty();

  Set<T> toSet() {
    return map((t) => {t}).orElseGet({});
  }

  List<T> toList() {
    return map((t) => [t]).orElseGet([]);
  }
}

class Present<T> extends Optional<T> {
  final T value;

  const Present(this.value) : super();

  Optional<N> map<N>(final N Function(T) mapper) {
    return Optional.of(mapper(value));
  }

  Optional<N> flatMap<N>(final Optional<N> Function(T) mapper) {
    return mapper(value);
  }

  Optional<T> filter(final Predicate<T> predicate) {
    return predicate(value) ? this : Empty();
  }

  @override
  bool equals(final T value) => value == this.value;

  @override
  Optional<T> ifPresent(final void Function(T value) action) {
    action(value);
    return this;
  }

  @override
  bool get isPresent => true;

  @override
  String toString() => 'Present { value: $value }';

  @override
  List<Object> get props => [value];

  @override
  T orElse(final T Function() ignored) => value;

  @override
  T orElseGet(final T ignored) => value;

  @override
  T orThrow(final Exception ignored) => value;
}

class Empty<T> extends Optional<T> {
  const Empty() : super();

  Optional<N> map<N>(final N Function(T) mapper) => Empty();

  Optional<N> flatMap<N>(final Optional<N> Function(T) mapper) => Empty();

  Optional<T> filter(final Predicate<T> predicate) => this;

  @override
  bool equals(T value) => false;

  @override
  Optional<T> ifPresent(void Function(T p1) action) => this;

  @override
  bool get isPresent => false;

  @override
  T orElse(final T Function() supplier) => supplier();

  @override
  T orElseGet(final T value) => value;

  @override
  T orThrow(final Exception exception) => throw exception;

  @override
  String toString() => 'Empty { }';

  @override
  List<Object> get props => [];
}
