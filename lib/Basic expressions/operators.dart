import 'dart:html';

import 'package:flutter/material.dart';
void main(){
  // a++
  // a + b
  // a = b
  // a == b
  // c ? a : b
  // a is Type   is 类型判断


  //合理添加括号
//   // Parentheses improve readability.
//   if ((n % i == 0) && (d % i == 0)) ...
//
// // Harder to read, but equivalent.
//   if (n % i == 0 && d % i == 0) ...

  int a;
  int b;

  a = 0;
  b = ++a; // Increment a before b gets its value.
  assert(a == b); // 1 == 1

  a = 0;
  b = a++; // Increment a after b gets its value.
  assert(a != b); // 1 != 0

  a = 0;
  b = --a; // Decrement a before b gets its value.
  assert(a == b); // -1 == -1

  a = 0;
  b = a--; // Decrement a after b gets its value.
  assert(a != b); // -1 != 0

  //assert(2 == 3);// 2 == 3 is not true
  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(2 <= 3);

  //as
  // (employee as Person).firstName = 'Bob';  //employee是Person类型
  // if (employee is Person) {//is 类型判断
  //   // Type check
  //   employee.firstName = 'Bob';
  // }

  // Dart中，as运算符用于执行类型转换，将一个表达式的类型显式转换为另一个类型。这在以下情况下非常有用：
  //
  // 当您需要将一个父类的实例转换为其子类的实例。
  // 当您从一个通用的类型转换为一个具体的类型。
  // 当Dart无法确定表达式的确切类型时，您可以使用as来进行显式类型断言。

  // var a = 2; // Assign using =
  // a *= 3; // Assign and multiply: a = a * 3
  // assert(a == 6);

  // if (!done && (col == 0 || col == 3)) {
  //   // ...Do something...
  // }

  final value = 0x22;
  final bitmask = 0x0f;

  assert((value & bitmask) == 0x02); // AND
  assert((value & ~bitmask) == 0x20); // AND NOT
  assert((value | bitmask) == 0x2f); // OR
  assert((value ^ bitmask) == 0x2d); // XOR

  assert((value << 4) == 0x220); // Shift left
  assert((value >> 4) == 0x02); // Shift right

// Shift right example that results in different behavior on web
// because the operand value changes when masked to 32 bits:
  assert((-value >> 4) == -0x03);

  // assert((value >>> 4) == 0x02); // Unsigned shift right
  // assert((-value >>> 4) > 0); // Unsigned shift right
  //2.14版本及以上才使用 >>>

  // 条件 ? 表达式 1 : 表达式 2
  // 如果条件为 true，执行表达式 1并返回执行结果，否则执行表达式 2 并返回执行结果。
  //
  // 表达式 1 ?? 表达式 2
  // 如果表达式 1 为非 null 则返回其值，否则执行表达式 2 并返回其值。

  // var visibility = isPublic ? 'public' : 'private';
  // String playerName1(String? name1) => name1 ?? 'Guest';
  //
  // // Slightly longer version uses ?: operator.
  // String playerName(String? name) =&gt;
  // name != null ? name : 'Guest';

// Very long version uses if-else statement.
  String playerName2(String? name) {
  if (name != null) {
  return name;
  } else {
  return 'Guest';
  }
  }

  //级联运算符 (.., ?..) 可以让你在同一个对象上连续调用多个对象的变量或方法。
  var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;

  querySelector('#confirm') // Get an object.
    ?..text = 'Confirm' // Use its members.
    ..classes.add('important')
    ..onClick.listen((e) => window.alert('Confirmed!'))
    ..scrollIntoView();

  var button = querySelector('#confirm');
  button?.text = 'Confirm';
  button?.classes.add('important');
  button?.onClick.listen((e) => window.alert('Confirmed!'));
  button?.scrollIntoView();

  // final addressBook = (AddressBookBuilder()
  //   ..name = 'jenny'
  //   ..email = 'jenny@example.com'
  //   ..phone = (PhoneNumberBuilder()
  //     ..number = '415-555-0100'
  //     ..label = 'home')
  //       .build())
  //     .build();

  // var sb = StringBuffer();
  // sb.write('foo')
  //   ..write('bar'); // Error: method 'write' isn't defined for 'void'.


  // 运算符	  名字	              描述
  // ()	      使用方法	          代表调用一个方法
  // []	      访问 List	        访问 List 中特定位置的元素
  // ?[]	    判空访问 List	      左侧调用者不为空时，访问 List 中特定位置的元素
  //  .	      访问成员	          成员访问符
  //  ?.	    条件访问成员	      与上述成员访问符类似，但是左边的操作对象不能为 null，例如 foo?.bar，如果 foo 为 null 则返回 null ，否则返回 bar
  // !	      空断言操作符	      将表达式的类型转换为其基础类型，如果转换失败会抛出运行时异常。例如 foo!.bar，如果 foo 为 null，则抛出运行时异常

}