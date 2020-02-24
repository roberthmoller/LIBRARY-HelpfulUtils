# H(elpful)Utils
![Release](https://github.com/rhmoeller/HUtils/workflows/Release/badge.svg?branch=master)
[![Pub](https://img.shields.io/badge/PUB-0.0.1-green?style=for-the-badge)](https://pub.dartlang.org/packages/h_utils)

## About
This is a set of helper classes I feel that Dart was missing.

**Disclaimer** this is made for personal use only.
## Features
* [Usage](#usage)
    * [Date & Time](#date--time)
    * [Control Flow](#control-flow)
      * [Method](#method)
      * [Supplier](#supplier)
      * [Consumer](#consumer)
      * [Predicate](#predicate)
      * [Switcher](#switcher)
      * [Optional](#optional)
      * [Either](#either)
    * [Immutability](#immutability)

## Usage

### Date & Time

### Control Flow
#### Method
A function that takes an input of type `I` and returns a value of `O`.
```dart
typedef Method<I, O> = O Function(I);  
```

**Usage**
```dart
final Method<int, String> method = (int input) => int.toString();
```

#### Supplier
#### Consumer
#### Predicate
#### Switcher
#### Optional
#### Either

### Immutability
