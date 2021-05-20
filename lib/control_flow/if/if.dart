/*
 * Copyright (c) 2021 Robert Hjortsholm Moeller
 */
import '../functional.dart';

abstract class If {
  const If._();

  factory If(final bool statement) {
    return statement ? True() : False();
  }

  Then<If> get isTrue;

  Then<If> get isFalse;
}

class True extends If {
  const True() : super._();

  IgnoredThen<If> get isFalse => IgnoredThen(this);

  PursuedThen<If> get isTrue => PursuedThen(this);
}

class False extends If {
  const False() : super._();

  PursuedThen<If> get isFalse => PursuedThen(this);

  IgnoredThen<If> get isTrue => IgnoredThen(this);
}

abstract class Then<PARENT> {
  final PARENT parent;

  const Then(this.parent);

  PARENT then(final void Function() action);

  // NEW_PARENT map<NEW_PARENT>(final NEW_PARENT Function() action);
}

class IgnoredThen<PARENT> extends Then<PARENT> {
  const IgnoredThen(final PARENT parent) : super(parent);

  PARENT then(final void Function() ignored) => this.parent;

  // todo: fix this?
  // NEW_PARENT map<NEW_PARENT>(final NEW_PARENT Function() ignored) => null;
}

class PursuedThen<PARENT> extends Then<PARENT> {
  const PursuedThen(final PARENT parent) : super(parent);

  PARENT then(final void Function() action) => this.parent..execute(action);

  // NEW_PARENT map<NEW_PARENT>(final NEW_PARENT Function() action) => action();
}
