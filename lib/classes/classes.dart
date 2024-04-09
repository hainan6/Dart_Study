Classes

Dart is an object-oriented language with classes and mixin-based inheritance. Every object is an instance of a class, and all classes except Null descend from Object. Mixin-based inheritance means that although every class (except for the top class, Object?) has exactly one superclass, a class body can be reused in multiple class hierarchies. Extension methods are a way to add functionality to a class without changing the class or creating a subclass. Class modifiers allow you to control how libraries can subtype a class.
Using class members
#

Objects have members consisting of functions and data (methods and instance variables, respectively). When you call a method, you invoke it on an object: the method has access to that object's functions and data.

Use a dot (.) to refer to an instance variable or method:

var p = Point(2, 2);

// Get the value of y.
assert(p.y == 2);

// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));

Use ?. instead of . to avoid an exception when the leftmost operand is null:

// If p is non-null, set a variable equal to its y value.
var a = p?.y;

Using constructors
#

You can create an object using a constructor. Constructor names can be either ClassName or ClassName.identifier. For example, the following code creates Point objects using the Point() and Point.fromJson() constructors:

var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});

The following code has the same effect, but uses the optional new keyword before the constructor name:

var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});

Some classes provide constant constructors. To create a compile-time constant using a constant constructor, put the const keyword before the constructor name:

var p = const ImmutablePoint(2, 2);

Constructing two identical compile-time constants results in a single, canonical instance:

var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!

Within a constant context, you can omit the const before a constructor or literal. For example, look at this code, which creates a const map:

// Lots of const keywords here.
const pointAndLine = const {
'point': const [const ImmutablePoint(0, 0)],
'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};

You can omit all but the first use of the const keyword:

// Only one const, which establishes the constant context.
const pointAndLine = {
'point': [ImmutablePoint(0, 0)],
'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};

If a constant constructor is outside of a constant context and is invoked without const, it creates a non-constant object:

var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!

Getting an object's type
#

To get an object's type at runtime, you can use the Object property runtimeType, which returns a Type object.

print('The type of a is ${a.runtimeType}');

Warning

Use a type test operator rather than runtimeType to test an object's type. In production environments, the test object is Type is more stable than the test object.runtimeType == Type.

Up to here, you've seen how to use classes. The rest of this section shows how to implement classes.
Instance variables
#

Here's how you declare instance variables:

class Point {
double? x; // Declare instance variable x, initially null.
double? y; // Declare y, initially null.
double z = 0; // Declare z, initially 0.
}

An uninitialized instance variable declared with a nullable type has the value null. Non-nullable instance variables must be initialized at declaration.

All instance variables generate an implicit getter method. Non-final instance variables and late final instance variables without initializers also generate an implicit setter method. For details, check out Getters and setters.

class Point {
double? x; // Declare instance variable x, initially null.
double? y; // Declare y, initially null.
}

void main() {
var point = Point();
point.x = 4; // Use the setter method for x.
assert(point.x == 4); // Use the getter method for x.
assert(point.y == null); // Values default to null.
}

Initializing a non-late instance variable where it's declared sets the value when the instance is created, before the constructor and its initializer list execute. As a result, the initializing expression (after the =) of a non-late instance variable can't access this.

double initialX = 1.5;

class Point {
// OK, can access declarations that do not depend on `this`:
double? x = initialX;

// ERROR, can't access `this` in non-`late` initializer:
double? y = this.x;

// OK, can access `this` in `late` initializer:
late double? z = this.x;

// OK, `this.fieldName` is a parameter declaration, not an expression:
Point(this.x, this.y);
}

Instance variables can be final, in which case they must be set exactly once. Initialize final, non-late instance variables at declaration, using a constructor parameter, or using a constructor's initializer list:

class ProfileMark {
final String name;
final DateTime start = DateTime.now();

ProfileMark(this.name);
ProfileMark.unnamed() : name = '';
}

If you need to assign the value of a final instance variable after the constructor body starts, you can use one of the following:

Use a factory constructor.
Use late final, but be careful: a late final without an initializer adds a setter to the API.

Implicit interfaces
#

Every class implicitly defines an interface containing all the instance members of the class and of any interfaces it implements. If you want to create a class A that supports class B's API without inheriting B's implementation, class A should implement the B interface.

A class implements one or more interfaces by declaring them in an implements clause and then providing the APIs required by the interfaces. For example:

// A person. The implicit interface contains greet().
class Person {
// In the interface, but visible only in this library.
final String _name;

// Not in the interface, since this is a constructor.
Person(this._name);

// In the interface.
String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
String get _name => '';

String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
print(greetBob(Person('Kathy')));
print(greetBob(Impostor()));
}

Here's an example of specifying that a class implements multiple interfaces:

class Point implements Comparable, Location {...}

Class variables and methods
#

Use the static keyword to implement class-wide variables and methods.
Static variables
#

Static variables (class variables) are useful for class-wide state and constants:

class Queue {
static const initialCapacity = 16;
// ···
}

void main() {
assert(Queue.initialCapacity == 16);
}

Static variables aren't initialized until they're used.
Note

This page follows the style guide recommendation of preferring lowerCamelCase for constant names.
Static methods
#

Static methods (class methods) don't operate on an instance, and thus don't have access to this. They do, however, have access to static variables. As the following example shows, you invoke static methods directly on a class:

import 'dart:math';

class Point {
double x, y;
Point(this.x, this.y);

static double distanceBetween(Point a, Point b) {
var dx = a.x - b.x;
var dy = a.y - b.y;
return sqrt(dx * dx + dy * dy);
}
}

void main() {
var a = Point(2, 2);
var b = Point(4, 4);
var distance = Point.distanceBetween(a, b);
assert(2.8 < distance && distance < 2.9);
print(distance);
}