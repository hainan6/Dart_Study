内置类型

Dart 语言支持下列内容：

Numbers (int, double)
Strings (String)
Booleans (bool)
Lists (也被称为 arrays)

Sets (Set)
Maps (Map)
Runes (常用于在 Characters API 中进行字符替换)

Symbols (Symbol)
The value null (Null)
使用字面量来创建对象也受到支持。例如 ‘This is a string’ 是一个字符串字面量，true 是一个布尔字面量。

由于 Dart 中每个变量引用都指向一个对象（一个 类 的实例），通常也可以使用 构造器 来初始化变量。一些内置的类型有它们自己的构造器。例如你可以使用 Map() 来创建一个 map 对象。
Numbers

Dart 支持两种 Number 类型：
int

整数值；长度不超过 64 位，具体取值范围 依赖于不同的平台。在 DartVM 上其取值位于 -263 至 263 - 1 之间。在 Web 上，整型数值代表着 JavaScript 的数字（64 位无小数浮点型），其允许的取值范围在 -253 至 253 - 1 之间。
double

64 位的双精度浮点数字，且符合 IEEE 754 标准。

int 和 double 都是 num 的子类。 num 中定义了一些基本的运算符比如 +、-、*、/ 等，还定义了 abs()、ceil() 和 floor() 等方法（位运算符，比如 >> 定义在 int 中）。如果 num 及其子类不满足你的要求，可以查看 dart:math 库中的 API。

整数是不带小数点的数字，下面是一些定义整数字面量的例子：

var x = 1;
var hex = 0xDEADBEEF;

1
2

如果一个数字包含了小数点，那么它就是浮点型的。下面是一些定义浮点数字面量的例子：

var y = 1.1;
var exponents = 1.42e5;

1
2

整型字面量将会在必要的时候自动转换成浮点数字面量：

double z = 1; // Equivalent to double z = 1.0.

1

下面是字符串和数字之间转换的方式：

// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15

整型支持传统的位移操作，比如移位（<<、>> 和 >>>）、补码 (~)、按位与 (&)、按位或 (|) 以及按位异或 (^)，例如：

assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 | 4) == 7); // 0011 | 0100 == 0111
assert((3 & 4) == 0); // 0011 & 0100 == 0000

1
2
3

数字字面量为编译时常量。很多算术表达式只要其操作数是常量，则表达式结果也是编译时常量。

const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;

1
2
3

Strings

Dart 字符串（String 对象）包含了 UTF-16 编码的字符序列。可以使用单引号或者双引号来创建字符串：

var s1 = '使用单引号创建字符串字面量。';
var s2 = "双引号也可以用于创建字符串字面量。";
var s3 = '使用单引号创建字符串时可以使用斜杠来转义那些与单引号冲突的字符串：\'。';
var s4 = "而在双引号中则不需要使用转义与单引号冲突的字符串：'";

1
2
3
4

在字符串中，请以 ${表达式} 的形式使用表达式，如果表达式是一个标识符，可以省略掉 {}。如果表达式的结果为一个对象，则 Dart 会调用该对象的 toString 方法来获取一个字符串。

var s = '字符串插值';

assert('Dart 有$s，使用起来非常方便。' == 'Dart 有字符串插值，使用起来非常方便。');
assert('使用${s.substring(3,5)}表达式也非常方便' == '使用插值表达式也非常方便。');

1
2
3
4

备注:== 运算符负责判断两个对象是否等同，比如，如果两个字符串包含一样的字符编码序列，则表示他们是等同的。

你可以使用 + 运算符或并列放置多个字符串来连接字符串：

var s1 = '可以拼接'
'字符串'
"即便它们不在同一行。";
assert(s1 == '可以拼接字符串即便它们不在同一行。');

var s2 = '使用加号 + 运算符' + '也可以达到相同的效果。';
assert(s2 == '使用加号 + 运算符也可以达到相同的效果。');

1
2
3
4
5
6
7

使用三个单引号或者三个双引号也能创建多行字符串：

var s1 = '''
你可以像这样创建多行字符串。
''';

1
2
3

var s2 = """这也是一个多行字符串。""";

1

在字符串前加上 r 作为前缀创建 “raw” 字符串（即不会被做任何处理（比如转义）的字符串）：

var s = r'在 raw 字符串中，转义字符串 \n 会直接输出 “\n” 而不是转义为换行。';

1

字符串字面量是一个编译时常量，只要是编译时常量 (null、数字、字符串、布尔) 都可以作为字符串字面量的插值表达式：

// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';

1
2
3
4
5
6
7
8
9
10
11
12
13

布尔类型

Dart 使用 bool 关键字表示布尔类型，布尔类型只有两个对象 true 和 false，两者都是编译时常量。

Dart 的类型安全不允许你使用类似 if (nonbooleanValue) 或者 assert (nonbooleanValue) 这样的代码检查布尔值。相反，你应该总是显式地检查布尔值，比如像下面的代码这样：

// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints <= 0);

// Check for null.
var unicorn = null;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15

Lists

数组 (Array) 是几乎所有编程语言中最常见的集合类型，在 Dart 中数组由 List 对象表示。通常称之为 List。

Dart 中的列表字面量是由逗号分隔的一串表达式或值并以方括号 ([]) 包裹而组成的。下面是一个 Dart List 的示例：

var list = [1, 2, 3];

1

你可以在 Dart 的集合类型的最后一个项目后添加逗号。这个尾随逗号并不会影响集合，但它能有效避免「复制粘贴」的错误。

var list = [
'Car',
'Boat',
'Plane',
];

1
2
3
4
5

// List 的下标索引从 0 开始，第一个元素的下标为 0，最后一个元素的下标为 list.length - 1。你可以像 JavaScript 中的用法那样获取 Dart 中 List 的长度以及元素：

var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);

// 在 List 字面量前添加 const 关键字会创建一个编译时常量：

var constantList = const [1, 2, 3];
// constantList[1] = 1; // This line will cause an error.


// Dart 在 2.3 引入了 扩展操作符（…）和 空感知扩展操作符（…?），它们提供了一种将多个元素插入集合的简洁方法。
//
// 例如，你可以使用扩展操作符（…）将一个 List 中的所有元素插入到另一个 List 中：

var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);


// 如果扩展操作符右边可能为 null ，你可以使用 null-aware 扩展操作符（…?）来避免产生异常：

var list2 = [0, ...?list];
assert(list2.length == 1);


// Dart 还同时引入了 集合中的 if 和 集合中的 for 操作，在构建集合时，可以使用条件判断 (if) 和循环 (for)。
//
// 下面示例是使用 集合中的 if 来创建一个 List 的示例，它可能包含 3 个或 4 个元素：

var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];



// 下面是使用 集合中的 for 将列表中的元素修改后添加到另一个列表中的示例：

var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
assert(listOfStrings[1] == '#1');



// Sets
//
// 在 Dart 中，set 是一组特定元素的无序集合。 Dart 支持的集合由集合的字面量和 Set 类提供。
//
// 下面是使用 Set 字面量来创建一个 Set 集合的方法：

var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};



// 可以使用在 {} 前加上类型参数的方式创建一个空的 Set，或者将 {} 赋值给一个 Set 类型的变量：

var names = <String>{};
// Set<String> names = {}; // This works, too.
// var names = {}; // Creates a map, not a set.


// 使用 add() 方法或 addAll() 方法向已存在的 Set 中添加项目：

var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);


// 使用 .length 可以获取 Set 中元素的数量：

var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
assert(elements.length == 5);


// 可以在 Set 变量前添加 const 关键字创建一个 Set 编译时常量：

final constantSet = const {
'fluorine',
'chlorine',
'bromine',
'iodine',
'astatine',
};
// constantSet.add('helium'); // This line will cause an error.



// 从 Dart 2.3 开始，Set 可以像 List 一样支持使用扩展操作符（… 和 …?）以及 Collection if 和 for 操作。
// Maps
//
// 通常来说，Map 是用来关联 keys 和 values 的对象。其中键和值都可以是任何类型的对象。每个 键 只能出现一次但是 值 可以重复出现多次。 Dart 中 Map 提供了 Map 字面量以及 Map 类型两种形式的 Map。
//
// 下面是一对使用 Map 字面量创建 Map 的例子：

var gifts = {
// Key:    Value
'first': 'partridge',
'second': 'turtledoves',
'fifth': 'golden rings'
};

var nobleGases = {
2: 'helium',
10: 'neon',
18: 'argon',
};



// 你也可以使用 Map 的构造器创建 Map：

var gifts = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';



// 向现有的 Map 中添加键值对与 JavaScript 的操作类似：

var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair


// 从一个 Map 中获取一个值的操作也与 JavaScript 类似：

var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');


// 如果检索的 Key 不存在于 Map 中则会返回一个 null：

var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);



// 使用 .length 可以获取 Map 中键值对的数量：

var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);


//
// 在一个 Map 字面量前添加 const 关键字可以创建一个 Map 编译时常量：

final constantMap = const {
2: 'helium',
10: 'neon',
18: 'argon',
};

// constantMap[2] = 'Helium'; // This line will cause an error.



// Map 可以像 List 一样支持使用扩展操作符（… 和 …?）以及集合的 if 和 for 操作。
// Runes 与 grapheme clusters
//
// 在 Dart 中，runes 公开了字符串的 Unicode 码位。使用 characters 包 来访问或者操作用户感知的字符，也被称为 Unicode (扩展) grapheme clusters。
//
// Unicode 编码为每一个字母、数字和符号都定义了一个唯一的数值。因为 Dart 中的字符串是一个 UTF-16 的字符序列，所以如果想要表示 32 位的 Unicode 数值则需要一种特殊的语法。
//
// 表示 Unicode 字符的常见方式是使用 \uXXXX，其中 XXXX 是一个四位数的 16 进制数字。例如心形字符（♥）的 Unicode 为 \u2665。对于不是四位数的 16 进制数字，需要使用大括号将其括起来。例如大笑的 emoji 表情（😆）的 Unicode 为 \u{1f600}。
//
// 如果你需要读写单个 Unicode 字符，可以使用 characters 包中定义的 characters getter。它将返回 Characters 对象作为一系列 grapheme clusters 的字符串。下面是使用 characters API 的样例：

import 'package:characters/characters.dart';

void main() {
var hi = 'Hi 🇩🇰';
print(hi);
print('The end of the string: ${hi.substring(hi.length - 1)}');
print('The last character: ${hi.characters.last}');
}



// Symbols
//
// Symbol 表示 Dart 中声明的操作符或者标识符。你几乎不会需要 Symbol，但是它们对于那些通过名称引用标识符的 API 很有用，因为代码压缩后，尽管标识符的名称会改变，但是它们的 Symbol 会保持不变。
//
// 可以使用在标识符前加 # 前缀来获取 Symbol：

#radix
#bar
