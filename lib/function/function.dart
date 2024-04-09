//函数
//
//Dart 是一种真正面向对象的语言，所以即便函数也是对象并且类型为 Function，这意味着函数可以被赋值给变量或者作为其它函数的参数。你也可以像调用函数一样调用 Dart 类的实例。
//
//下面是定义一个函数的例子：
//
//bool isNoble(int atomicNumber) {
//return _nobleGases[atomicNumber] != null;
//}
//
//1
//2
//3
//
//虽然高效 Dart 指南建议在 公开的 API 上定义返回类型，不过即便不定义，该函数也依然有效：
//
//isNoble(atomicNumber) {
//return _nobleGases[atomicNumber] != null;
//}
//
//1
//2
//3
//
//如果函数体内只包含一个表达式，你可以使用简写语法：
//
//bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
//
//1
//
//语法 => 表达式 是 { return 表达式; } 的简写， => 有时也称之为 箭头 函数。
//
//备注:在 => 与 ; 之间的只能是 表达式 而非 语句。比如你不能将一个 if语句 放在其中，但是可以放置 条件表达式。
//参数
//
//函数可以有两种形式的参数：必要参数 和 可选参数。必要参数定义在参数列表前面，可选参数则定义在必要参数后面。可选参数可以是 命名的 或 位置的。
//
//向函数传入参数或者定义函数参数时，可以使用 尾逗号。
//命名参数
//
//命名参数默认为可选参数，除非他们被特别标记为 required。
//
//定义函数时，使用 {参数1, 参数2, …} 来指定命名参数：如果你没有提供一个默认值，也没有使用 required 标记的话，那么它一定可空的类型，因为他们的默认值会是 null：
//
///// Sets the [bold] and [hidden] flags ...
//void enableFlags({bool? bold, bool? hidden}) {...}
//
//1
//2
//
//当调用函数时，你可以使用 参数名: 参数值 指定一个命名参数的值。例如：
//
//enableFlags(bold: true, hidden: false);
//
//1
//
//你可以使用 = 来为一个命名参数指定除了 null 以外的默认值。指定的默认值必须要为编译时的常量，例如：
//
///// Sets the [bold] and [hidden] flags ...
//void enableFlags({bool bold = false, bool hidden = false}) {...}
//
//// bold will be true; hidden will be false.
//enableFlags(bold: true);
//
//1
//2
//3
//4
//5
//
//如果你希望一个命名参数是强制需要使用的，调用者需要提供它的值，则你可以使用 required 进行声明：
//
//const Scrollbar({super.key, required Widget child});
//
//1
//
//当你创建一个不带 child 参数的 Scrollbar 时，分析器就会报告这里出了问题。
//
//尽管将位置参数放在最前面通常比较合理，但你也可以将命名参数放在参数列表的任意位置，让整个调用的方式看起来更适合你的 API：
//
//repeat(times: 2, () {
//...
//});
//
//1
//2
//3
//
//可选的位置参数
//
//使用 [] 将一系列参数包裹起来，即可将其标记为位置参数，因为它们的默认值是 null，所以如果你没有提供默认值的话，它们的类型必须得是允许为空 (nullable) 的类型。
//
//String say(String from, String msg, [String? device]) {
//var result = '$from says $msg';
//if (device != null) {
//result = '$result with a $device';
//}
//return result;
//}
//
//1
//2
//3
//4
//5
//6
//7
//
//下面是不使用可选参数调用上述函数的示例
//
//assert(say('Bob', 'Howdy') == 'Bob says Howdy');
//
//1
//
//下面是使用可选参数调用上述函数的示例：
//
//assert(say('Bob', 'Howdy', 'smoke signal') ==
//'Bob says Howdy with a smoke signal');
//
//1
//2
//
//你可以使用 = 来为一个位置可选参数指定除了 null 以外的默认值。指定的默认值必须要为编译时的常量，例如：
//
//String say(String from, String msg, [String device = 'carrier pigeon']) {
//var result = '$from says $msg with a $device';
//return result;
//}
//
//assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
//
//1
//2
//3
//4
//5
//6
//
//main() 函数
//
//每个 Dart 程序都必须有一个 main() 顶级函数作为程序的入口， main() 函数返回值为 void 并且有一个 List 类型的可选参数。
//
//下面是一个简单 main() 函数：
//
//void main() {
//print('Hello, World!');
//}
//
//1
//2
//3
//
//下面是使用命令行访问带参数的 main() 函数示例：
//
//// Run the app like this: dart args.dart 1 test
//void main(List<String> arguments) {
//print(arguments);
//
//assert(arguments.length == 2);
//assert(int.parse(arguments[0]) == 1);
//assert(arguments[1] == 'test');
//}
//
//1
//2
//3
//4
//5
//6
//7
//8
//
//你可以通过使用 参数库 来定义和解析命令行参数。
//函数是一级对象
//
//可以将函数作为参数传递给另一个函数。例如：
//
//void printElement(int element) {
//print(element);
//}
//
//var list = [1, 2, 3];
//
//// Pass printElement as a parameter.
//list.forEach(printElement);
//
//1
//2
//3
//4
//5
//6
//7
//8
//
//你也可以将函数赋值给一个变量，比如：
//
//var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
//assert(loudify('hello') == '!!! HELLO !!!');
//
//1
//2
//
//匿名函数
//
//大多数方法都是有名字的，比如 main() 或 printElement()。你可以创建一个没有名字的方法，称之为 匿名函数、 Lambda 表达式 或 Closure 闭包。你可以将匿名方法赋值给一个变量然后使用它，比如将该变量添加到集合或从中删除。
//
//匿名方法看起来与命名方法类似，在括号之间可以定义参数，参数之间用逗号分割。
//
//后面大括号中的内容则为函数体：
//
//([[类型] 参数[, …]]) {
//函数体;
//};
//
//1
//2
//3
//
//下面代码定义了只有一个参数 item 且没有参数类型的匿名方法。 List 中的每个元素都会调用这个函数，打印元素位置和值的字符串：
//
//const list = ['apples', 'bananas', 'oranges'];
//list.map((item) {
//return item.toUpperCase();
//}).forEach((item) {
//print('$item: ${item.length}');
//});
//
//1
//2
//3
//4
//5
//6
//
//如果函数体内只有一行返回语句，你可以使用胖箭头缩写法。粘贴下面代码到 DartPad 中并点击运行按钮，验证两个函数是否一致。
//
//list
//    .map((item) => item.toUpperCase())
//    .forEach((item) => print('$item: ${item.length}'));
//
//1
//2
//3
//
//词法作用域
//
//Dart 是词法有作用域语言，变量的作用域在写代码的时候就确定了，大括号内定义的变量只能在大括号内访问，与 Java 类似。
//
//下面是一个嵌套函数中变量在多个作用域中的示例：
//
//bool topLevel = true;
//
//void main() {
//var insideMain = true;
//
//void myFunction() {
//var insideFunction = true;
//
//void nestedFunction() {
//var insideNestedFunction = true;
//
//assert(topLevel);
//assert(insideMain);
//assert(insideFunction);
//assert(insideNestedFunction);
//}
//}
//}
//
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//12
//13
//14
//15
//16
//17
//18
//
//注意 nestedFunction() 函数可以访问包括顶层变量在内的所有的变量。
//词法闭包
//
//闭包 即一个函数对象，即使函数对象的调用在它原始作用域之外，依然能够访问在它词法作用域内的变量。
//
//函数可以封闭定义到它作用域内的变量。接下来的示例中，函数 makeAdder() 捕获了变量 addBy。无论函数在什么时候返回，它都可以使用捕获的 addBy 变量。
//
///// Returns a function that adds [addBy] to the
///// function's argument.
//Function makeAdder(int addBy) {
//return (int i) => addBy + i;
//}
//
//void main() {
//// Create a function that adds 2.
//var add2 = makeAdder(2);
//
//// Create a function that adds 4.
//var add4 = makeAdder(4);
//
//assert(add2(3) == 5);
//assert(add4(3) == 7);
//}
//
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//12
//13
//14
//15
//16
//17
//
//测试函数是否相等
//
//下面是顶级函数、静态方法和实例方法相等性的测试示例：
//
//void foo() {} // A top-level function
//
//class A {
//static void bar() {} // A static method
//void baz() {} // An instance method
//}
//
//void main() {
//Function x;
//
//// Comparing top-level functions.
//x = foo;
//assert(foo == x);
//
//// Comparing static methods.
//x = A.bar;
//assert(A.bar == x);
//
//// Comparing instance methods.
//var v = A(); // Instance #1 of A
//var w = A(); // Instance #2 of A
//var y = w;
//x = w.baz;
//
//// These closures refer to the same instance (#2),
//// so they're equal.
//assert(y.baz == x);
//
//// These closures refer to different instances,
//// so they're unequal.
//assert(v.baz != w.baz);
//}
//
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//12
//13
//14
//15
//16
//17
//18
//19
//20
//21
//22
//23
//24
//25
//26
//27
//28
//29
//30
//31
//32
//
//返回值
//
//所有的函数都有返回值。没有显式返回语句的函数最后一行默认为执行 return null;。
//
//foo() {}
//
//assert(foo() == null);
//
//————————————————
//
//版权声明：本文为博主原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接和本声明。
//
//原文链接：https://blog.csdn.net/qq_43358469/article/details/131240055