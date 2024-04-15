//类

//Dart 是支持基于 mixin 继承机制的面向对象语言，所有对象都是一个类的实例，而除了 Null 以外的所有的类都继承自 Object 类。 基于 mixin 的继承 意味着尽管每个类（top class Object? 除外）都只有一个超类，一个类的代码可以在其它多个类继承中重复使用。 扩展方法 是一种在不更改类或创建子类的情况下向类添加功能的方式。
//使用类的成员

//对象的 成员 由函数和数据（即 方法 和 实例变量）组成。方法的 调用 要通过对象来完成，这种方式可以访问对象的函数和数据。

//使用（.）来访问对象的实例变量或方法：

var p = Point(2, 2);

// Get the value of y.
assert(p.y == 2);

// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));

//使用 ?. 代替 . 可以避免因为左边表达式为 null 而导致的问题：

// If p is non-null, set a variable equal to its y value.
var a = p?.y;


//使用构造函数

//可以使用 构造函数 来创建一个对象。构造函数的命名方式可以为 类名 或 类名 . 标识符 的形式。例如下述代码分别使用 Point() 和 Point.fromJson() 两种构造器创建了 Point 对象：

var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});

//以下代码具有相同的效果，但是构造函数名前面的的 new 关键字是可选的：

var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});


//一些类提供了常量构造函数。使用常量构造函数，在构造函数名之前加 const 关键字，来创建编译时常量时：

var p = const ImmutablePoint(2, 2);

//两个使用相同构造函数相同参数值构造的编译时常量是同一个对象：

var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!

// 在 常量上下文 场景中，你可以省略掉构造函数或字面量前的 const 关键字。例如下面的例子中我们创建了一个常量 Map：

// Lots of const keywords here.
const pointAndLine = const {
'point': const [const ImmutablePoint(0, 0)],
'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};

// 根据上下文，你可以只保留第一个 const 关键字，其余的全部省略：

// Only one const, which establishes the constant context.
const pointAndLine = {
'point': [ImmutablePoint(0, 0)],
'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};

// 但是如果无法根据上下文判断是否可以省略 const，则不能省略掉 const 关键字，否则将会创建一个 非常量对象 例如：

var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!


// 获取对象的类型
//
// 可以使用 Object 对象的 runtimeType 属性在运行时获取一个对象的类型，该对象类型是 Type 的实例。

print('The type of a is ${a.runtimeType}');

// 到目前为止，我们已经了解了如何 使用 类。本节的其余部分将向你介绍如何 实现 一个类。
// 实例变量
//
// 下面是声明实例变量的示例：

class Point {
double? x; // Declare instance variable x, initially null.
double? y; // Declare y, initially null.
double z = 0; // Declare z, initially 0.
}

// 所有未初始化的实例变量其值均为 null。
//
// 所有实例变量均会隐式地声明一个 Getter 方法。非终值的实例变量和 late final 声明但未声明初始化的实例变量还会隐式地声明一个 Setter 方法。
//
// 如果你在实例中声明了没有 late 修饰的变量，它会在实例初始化时早于构造方法进行赋值。因此，没有使用 late修饰的变量无法访问到 this。

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

class ProfileMark {
final String name;
final DateTime start = DateTime.now();

ProfileMark(this.name);
ProfileMark.unnamed() : name = '';
}





// 隐式接口
//
// 每一个类都隐式地定义了一个接口并实现了该接口，这个接口包含所有这个类的实例成员以及这个类所实现的其它接口。如果想要创建一个 A 类支持调用 B 类的 API 且不想继承 B 类，则可以实现 B 类的接口。
//
// 一个类可以通过关键字 implements 来实现一个或多个接口并实现每个接口定义的 API：

class="dart prettyprint lang-dart">// A person. The implicit interface contains greet().
class Person {
// In the interface, but visible only in this library.
final String _name;

// Not in the interface, since this is a constructor.
Person(this._name);

// In the interface.
String greet(String who) =&gt; 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
String get _name =&gt; '';

String greet(String who) =&gt; 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) =&gt; person.greet('Bob');

void main() {
print(greetBob(Person('Kathy')));
print(greetBob(Impostor()));
}

// 如果需要实现多个类接口，可以使用逗号分隔每个接口类：

class Point implements Comparable, Location {...}


import 'string_apis.dart';
...
print('42'.padLeft(5)); // Use a String method.
print('42'.parseInt()); // Use an extension method.


// 枚举类型
//
// 枚举类型是一种特殊的类型，也称为 enumerations 或 enums，用于定义一些固定数量的常量值。
//
// 备注:
//
// 所有的枚举都继承于 Enum 类。枚举类是封闭的，即不能被继承、被实现、被 mixin 混入或显式被实例化。
//
// 抽象类和 mixin 可以显式的实现或继承 Enum，但只有枚举可以实现或混入这个类，其他类无法享有同样的操作。
// 声明简单的枚举
//
// 你可以使用关键字 enum 来定义简单的枚举类型和枚举值：

enum Color { red, green, blue }

// 声明增强的枚举类型
//
// Dart 中的枚举也支持定义字段、方法和常量构造，常量构造只能构造出已知数量的常量实例（已定义的枚举值）。
//
// 你可以使用与定义类 类似的语句来定义增强的枚举，但是这样的定义有一些限制条件：
//
// 实例的字段必须是 final，包括由 mixin 混入的字段。
//
// 所有的实例化构造 必须以 const 修饰。
//
// 工厂构造 只能返回已知的一个枚举实例。
//
// 由于 Enum 已经自动进行了继承，所以枚举类不能再继承其他类。
//
// 不能重载 index、hashCode 和比较操作符 ==。
//
// 不能声明 values 字段，否则它将与枚举本身的静态 values getter 冲突。
//
// 在进行枚举定义时，所有的实例都需要首先进行声明，且至少要声明一个枚举实例。
//
// 下方是一个增强枚举的例子，它包含多个枚举实例、成员变量、getter 并且实现了接口：

enum Vehicle implements Comparable&lt;Vehicle&gt; {
car(tires: 4, passengers: 5, carbonPerKilometer: 400),
bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

const Vehicle({
required this.tires,
required this.passengers,
required this.carbonPerKilometer,
});

final int tires;
final int passengers;
final int carbonPerKilometer;

int get carbonFootprint =&gt; (carbonPerKilometer / passengers).round();

@override
int compareTo(Vehicle other) =&gt; carbonFootprint - other.carbonFootprint;
}

//使用枚举

//你可以像访问 静态变量 一样访问枚举值：

final favoriteColor = Color.blue;
if (favoriteColor == Color.blue) {
print('Your favorite color is blue!');
}


// 每一个枚举值都有一个名为 index 成员变量的 Getter 方法，该方法将会返回以 0 为基准索引的位置值。例如，第一个枚举值的索引是 0 ，第二个枚举值的索引是 1。以此类推。

assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);

// 想要获得全部的枚举值，使用枚举类的 values 方法获取包含它们的列表：

List<Color> colors = Color.values;
assert(colors[2] == Color.blue);

// 你可以在 Switch 语句中使用枚举，但是需要注意的是必须处理枚举值的每一种情况，即每一个枚举值都必须成为一个 case 子句，不然会出现警告：

var aColor = Color.blue;

switch (aColor) {
case Color.red:
print('Red as roses!');
break;
case Color.green:
print('Green as grass!');
break;
default: // Without this, you see a WARNING.
print(aColor); // 'Color.blue'
}

// 如果你想要获取一个枚举值的名称，例如 Color.blue 的 'blue'，请使用 .name 属性：
//
// print(Color.blue.name); // 'blue'
//





// 类变量和方法
//
// 使用关键字 static 可以声明类变量或类方法。
// 静态变量
//
// 静态变量（即类变量）常用于声明类范围内所属的状态变量和常量：

class Queue {
static const initialCapacity = 16;
// ···
}

void main() {
assert(Queue.initialCapacity == 16);
}

// 静态变量在其首次被使用的时候才被初始化。
// 静态方法
//
// 静态方法（即类方法）不能对实例进行操作，因此不能使用 this。但是他们可以访问静态变量。如下面的例子所示，你可以在一个类上直接调用静态方法：

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
assert(2.8 &lt; distance &amp;&amp; distance &lt; 2.9);
print(distance);
}



// 备注:
//
// 对于一些通用或常用的静态方法，应该将其定义为顶级函数而非静态方法。
//
// 可以将静态方法作为编译时常量。例如，你可以将静态方法作为一个参数传递给一个常量构造函数。
