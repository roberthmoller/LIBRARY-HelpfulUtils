import 'package:h_utils/control_flow/conditions.dart';
import 'package:h_utils/control_flow/method.dart';
import 'package:h_utils/control_flow/optional.dart';
import 'package:h_utils/control_flow/supplier.dart';

typedef Recovery<T> = T Function(Exception exception);

class Try<T> {
  final Supplier<T> _supplier;
  final Map<Type, Recovery<T>> _recoveries;

  Try._({final Supplier<T> supplier, final Map<Type, Recovery<T>> recoveries})
      : this._supplier = supplier,
        this._recoveries = recoveries;

  static Try<T> of<T>(final Supplier<T> supplier) {
    return Try._(supplier: supplier, recoveries: Map());
  }

  static Try<void> run(final Supplier<void> supplier) {
    return Try._(supplier: supplier, recoveries: Map());
  }

  static Try<T> withResource<T>(final T resource) {
    return of(Suppliers.of(resource));
  }

  Try<U> map<U>(final Method<T, U> f) {
    return Try._(
      supplier: _supplier.map(f),
      recoveries: _recoveries.map((type, recovery) => MapEntry<Type, Recovery<U>>(type, recovery.map(f))),
    );
  }

  Try<T> recover<E extends Exception>(final Recovery<T> recovery) {
    return _copyWith(recoveries: Map.from(_recoveries)..putIfAbsent(E, () => recovery));
  }

  T get() {
    try {
      return _supplier.get();
    } catch (e) {
      return Optional.of(_recoveries[e.runtimeType]).filter((recovery) => notNull(e)).map((recovery) => recovery(e)).orThrow(e);
    }
  }


  Optional<T> toOptional() {
    try {
      return Optional.of(_supplier.get());
    } catch (e) {
      return Optional.of(_recoveries[e.runtimeType]).filter((recovery) => notNull(e)).map((recovery) => recovery(e));
    }
  }

  Try<T> _copyWith({final Supplier<T> supplier, final Map<Type, Recovery<T>> recoveries}) {
    return Try._(
      supplier: supplier ?? this._supplier,
      recoveries: recoveries ?? this._recoveries,
    );
  }
}
