# H(elpful)Utils
![Release](https://github.com/rhmoeller/HUtils/workflows/Release/badge.svg?branch=master)
[![Pub](https://img.shields.io/badge/PUB-0.0.1-green?style=for-the-badge)](https://pub.dartlang.org/packages/h_utils)
This is a work in progress
## About
This is a set of helper classes I feel that Dart was missing.

**Disclaimer** keep in mind that this is made for personal use only.
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

**Value**
```dart
final Method<dynamic, int> method = value(2);
method(4); // returns 2
```

**Map**
```dart
final Method<int, int> method = (int input) => int * 2;
method.map((number) => number / 2)(4); // returns 4
```

**Also**
```dart
final Method<String, String> method = (String input) => "Hello $input";
final Method<String, String> printedMethod = method.also((String input) => print(input));
also("World"); // prints World, returns Hello World
```

**Format**
```dart
final Method<String, String> method = (String input) => "Hello $input";
method.format("{}, how are you?")("World"); // returns Hello World, how are you?
```

**ForEach**
```dart
final Method<String, String> method = (String input) => "Hello $input";
method.format("{}, how are you?")("World"); // Hello World, how are you?
```

#### Supplier
#### Consumer
#### Predicate
#### Switcher
#### Optional
#### Either

### Immutability
