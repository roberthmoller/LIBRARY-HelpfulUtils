/*
 * Copyright (c) 2020 Robert Hjortsholm Moeller
 */

abstract class Buildable<P> {
  Buildable();

  Buildable.build(final Builder<P> builder);
}

abstract class Builder<P> {
  P build();
}