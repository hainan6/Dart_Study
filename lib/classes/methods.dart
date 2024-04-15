// 方法
//
// 方法是为对象提供行为的函数。
// 实例方法
//
// 对象的实例方法可以访问实例变量和 this。下面的 distanceTo() 方法就是一个实例方法的例子：

import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

//操作符

// 运算符是有着特殊名称的实例方法。 Dart 允许您使用以下名称定义运算符：
// <	+	|	>>>
// >	/	^	[]
// <=	~/	&	[]=
// >=	*	<<	~
// -	%	>>	==

// 备注:
//
// 你可能注意到有一些 操作符 没有出现在列表中，例如 !=。因为它们仅仅是语法糖。表达式 e1 != e2 仅仅是 !(e1 == e2) 的一个语法糖。
//
// 为了表示重写操作符，我们使用 operator 标识来进行标记。下面是重写 + 和 - 操作符的例子

class="dart prettyprint lang-dart">class Vector {
final int x, y;

Vector(this.x, this.y);

Vector operator +(Vector v) =&gt; Vector(x + v.x, y + v.y);
Vector operator -(Vector v) =&gt; Vector(x - v.x, y - v.y);

@override
bool operator ==(Object other) =&gt;
other is Vector &amp;&amp; x == other.x &amp;&amp; y == other.y;

@override
int get hashCode =&gt; Object.hash(x, y);
}

void main() {
final v = Vector(2, 3);
final w = Vector(2, 2);

assert(v + w == Vector(4, 5));
assert(v - w == Vector(0, 1));
}


// Getter 和 Setter
//
// Getter 和 Setter 是一对用来读写对象属性的特殊方法，上面说过实例对象的每一个属性都有一个隐式的 Getter 方法，如果为非 final 属性的话还会有一个 Setter 方法，你可以使用 get 和 set 关键字为额外的属性添加 Getter 和 Setter 方法：

class="dart prettyprint lang-dart">class Rectangle {
double left, top, width, height;

Rectangle(this.left, this.top, this.width, this.height);

// Define two calculated properties: right and bottom.
double get right =&gt; left + width;
set right(double value) =&gt; left = value - width;
double get bottom =&gt; top + height;
set bottom(double value) =&gt; top = value - height;
}

void main() {
var rect = Rectangle(3, 4, 20, 15);
assert(rect.left == 3);
rect.right = 12;
assert(rect.left == -8);
}

// 使用 Getter 和 Setter 的好处是，你可以先使用你的实例变量，过一段时间过再将它们包裹成方法且不需要改动任何代码，即先定义后更改且不影响原有逻辑。
//
// 备注:
//
// 像自增（++）这样的操作符不管是否定义了 Getter 方法都会正确地执行。为了避免一些不必要的异常情况，运算符只会调用 Getter 一次，然后将其值存储在一个临时变量中。
// 抽象方法
//
// 实例方法、Getter 方法以及 Setter 方法都可以是抽象的，定义一个接口方法而不去做具体的实现让实现它的类去实现该方法，抽象方法只能存在于抽象类中。
//
// 直接使用分号（;）替代方法体即可声明一个抽象方法：

class="dart prettyprint lang-dart">abstract class Doer {
// Define instance variables and methods...

void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
void doSomething() {
// Provide an implementation, so the method is not abstract here...
}
}


// 抽象类
//
// 使用关键字 abstract 标识类可以让该类成为 抽象类，抽象类将无法被实例化。抽象类常用于声明接口方法、有时也会有具体的方法实现。如果想让抽象类同时可被实例化，可以为其定义工厂构造函数。
//
// 抽象类常常会包含 抽象方法。下面是一个声明具有抽象方法的抽象类示例：

class="dart prettyprint lang-dart">// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
// Define constructors, fields, methods...

void updateChildren(); // Abstract method.
}
