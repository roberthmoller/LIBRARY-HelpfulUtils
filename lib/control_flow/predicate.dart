/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

typedef Predicate<Input> = bool Function(Input);

class Predicates {
  static Predicate value(final bool value) {
    return (_) => value;
  }
}

extension EPredicate<Input> on Predicate<Input> {
  Predicate<Input> get not => (i) => !this(i);

  Predicate<Input> and(final Predicate<Input> predicate) => (i) => this(i) && predicate(i);

  Predicate<Input> or(final Predicate<Input> predicate) => (i) => this(i) || predicate(i);
}

Predicate<Input> both<Input>(final Predicate<Input> a, final Predicate<Input> b) => a.and(b);

Predicate<Input> either<Input>(final Predicate<Input> a, final Predicate<Input> b) => a.or(b);

Predicate<Input> neither<Input>(final Predicate<Input> a, final Predicate<Input> b) => (i) => (!a(i) || !b(i));

Predicate<Input> none<Input>(final Predicate<Input> a, final Predicate<Input> b) => (i) => (!a(i) && !b(i));

Predicate<Input> not<Input>(final Predicate<Input> predicate) => predicate.not;

Predicate<Input> always<Input>() => (i) => true;

Predicate<Input> never<Input>() => (i) => false;
