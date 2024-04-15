// 构造函数
//
// 声明一个与类名一样的函数即可声明一个构造函数（对于命名式构造函数 还可以添加额外的标识符）。大部分的构造函数形式是生成式构造函数，其用于创建一个类的实例：

class Point {
  double x = 0;
  double y = 0;

  Point(double x, double y) {
// See initializing formal parameters for a better way
// to initialize instance variables.
    this.x = x;
    this.y = y;
  }
}

// 使用 this 关键字引用当前实例。
//
// 备注:
//
// 当且仅当命名冲突时使用 this 关键字才有意义，否则 Dart 会忽略 this 关键字。
// 终值初始化
//
// 对于大多数编程语言来说在构造函数中为实例变量赋值的过程都是类似的，而 Dart 则提供了一种特殊的语法糖来简化该步骤。
//
// 构造中初始化的参数可以用于初始化非空或 final 修饰的变量，它们都必须被初始化或提供一个默认值。

class Point {
  final double x;
  final double y;

// Sets the x and y instance variables
// before the constructor body runs.
  Point(this.x, this.y);
}

// 在初始化时出现的变量默认是隐式终值，且只在初始化时可用。
// 默认构造函数
//
// 如果你没有声明构造函数，那么 Dart 会自动生成一个无参数的构造函数并且该构造函数会调用其父类的无参数构造方法。
// 构造函数不被继承
//
// 子类不会继承父类的构造函数，如果子类没有声明构造函数，那么只会有一个默认无参数的构造函数。
// 命名式构造函数
//
// 可以为一个类声明多个命名式构造函数来表达更明确的意图：

const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

// Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}

// 记住构造函数是不能被继承的，这将意味着子类不能继承父类的命名式构造函数，如果你想在子类中提供一个与父类命名构造函数名字一样的命名构造函数，则需要在子类中显式地声明。
// 调用父类非默认构造函数
//
// 默认情况下，子类的构造函数会调用父类的匿名无参数构造方法，并且该调用会在子类构造函数的函数体代码执行前，如果子类构造函数还有一个 初始化列表，那么该初始化列表会在调用父类的该构造函数之前被执行，总的来说，这三者的调用顺序如下：
//
// 初始化列表
//
// 父类的无参数构造函数
//
// 当前类的构造函数
//
// 如果父类没有匿名无参数构造函数，那么子类必须调用父类的其中一个构造函数，为子类的构造函数指定一个父类的构造函数只需在构造函数体前使用（:）指定。
//
// 下面的示例中，Employee 类的构造函数调用了父类 Person 的命名构造函数。点击运行按钮执行示例代码。

class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
// Person does not have a default constructor;
// you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
// Prints:
// in Person
// in Employee
// Instance of 'Employee'
}

// 因为参数会在子类构造函数被执行前传递给父类的构造函数，因此该参数也可以是一个表达式，比如一个函数：

class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
// ···
}

// 请注意:
//
// 传递给父类构造函数的参数不能使用 this 关键字，因为在参数传递的这一步骤，子类构造函数尚未执行，子类的实例对象也就还未初始化，因此所有的实例成员都不能被访问，但是类成员可以。
// 超类参数
//
// 为了不重复地将参数传递到超类构造的指定参数，你可以使用超类参数，直接在子类的构造中使用超类构造的某个参数。超类参数不能和重定向的参数一起使用。超类参数的表达式和写法与 终值初始化 类似：

class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

// Forward the x and y parameters to the default super constructor like:
// Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}

// 如果超类构造的位置参数已被使用，那么超类构造参数就不能再继续使用被占用的位置。但是超类构造参数可以始终是命名参数：

class Vector2d {
// ...

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
// ...

// Forward the y parameter to the named super constructor like:
// Vector3d.yzPlane({required double y, required this.z})
//       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}

// 版本提示:
//
// 使用超类参数需要 Dart SDK 版本 至少为 2.17。在先前的版本中，你必须手动传递所有的超类构造参数。
// 初始化列表
//
// 除了调用父类构造函数之外，还可以在构造函数体执行之前初始化实例变量。每个实例变量之间使用逗号分隔。

// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
y = json['y']! {
print('In Point.fromJson(): ($x, $y)');
}


// 请注意:
//
// 初始化列表表达式 = 右边的语句不能使用 this 关键字。
//
// 在开发模式下，你可以在初始化列表中使用 assert 来验证输入数据：

Point.withAssert(this.x, this.y) : assert(x >= 0) {
print('In Point.withAssert(): ($x, $y)');
}

// 使用初始化列表设置 final 字段非常方便，下面的示例中就使用初始化列表来设置了三个 final 变量的值。点击运行按钮执行示例代码。

import 'dart:math';

class Point {
final double x;
final double y;
final double distanceFromOrigin;

Point(double x, double y)
    : x = x,
y = y,
distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
var p = Point(2, 3);
print(p.distanceFromOrigin);
}


// 重定向构造函数
//
// 有时候类中的构造函数仅用于调用类中其它的构造函数，此时该构造函数没有函数体，只需在函数签名后使用（:）指定需要重定向到的其它构造函数 (使用 this 而非类名)：

class Point {
double x, y;

// The main constructor for this class.
Point(this.x, this.y);

// Delegates to the main constructor.
Point.alongXAxis(double x) : this(x, 0);
}

// 常量构造函数
//
// 如果类生成的对象都是不变的，可以在生成这些对象时就将其变为编译时常量。你可以在类的构造函数前加上 const 关键字并确保所有实例变量均为 final 来实现该功能。

class ImmutablePoint {
static const ImmutablePoint origin = ImmutablePoint(0, 0);

final double x, y;

const ImmutablePoint(this.x, this.y);
}


// 工厂构造函数
//
// 使用 factory 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，这将意味着使用该构造函数构造类的实例时并非总是会返回新的实例对象。例如，工厂构造函数可能会从缓存中返回一个实例，或者返回一个子类型的实例。
//
// 小提示:
//
// 另一种处理懒加载变量的方式是 使用 late final（谨慎使用）。
//
// 在如下的示例中， Logger 的工厂构造函数从缓存中返回对象，和 Logger.fromJson 工厂构造函数从 JSON 对象中初始化一个最终变量。

class Logger {
final String name;
bool mute = false;

// _cache is library-private, thanks to
// the _ in front of its name.
static final Map&lt;String, Logger&gt; _cache = &lt;String, Logger&gt;{};

factory Logger(String name) {
return _cache.putIfAbsent(name, () =&gt; Logger._internal(name));
}

factory Logger.fromJson(Map&lt;String, Object&gt; json) {
return Logger(json['name'].toString());
}

Logger._internal(this.name);

void log(String msg) {
if (!mute) print(msg);
}
}

// 备注:
//
// 在工厂构造函数中无法访问 this。
//
// 工厂构造函数的调用方式与其他构造函数一样：

var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);