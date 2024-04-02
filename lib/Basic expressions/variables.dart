void main1(){
  //print("Hello World");
  var name = 'Bob'; //var is used to declare a variable without specifying the type
  Object name2 = 'Bob';
  print(name2);
  String name3;     //Non-nullable type. Cannot be `null` but can be string. 使用变量之前对其进行初始化
  int lineCount1 = 0;//必须在使用非空变量之前初始化它们的值

  String ? name4; // ? is used to declare a nullable variable


  int? lineCount2; //可空变量是默认初始化为 null
  assert(lineCount2 == null);

  print(lineCount2);//null
  // int lineCount; //声明时可以不用初始化，但是使用之前必须初始化
  //
  // if (weLikeToCount) {
  //   lineCount = countLines();
  // } else {
  //   lineCount = 0;
  // }
}

//late
late String description;//使用late关键字，1.声明一个非空变量，但不在声明时初始化，2.延迟初始化一个变量

void main() {

  description = 'Feijoada!';//如果你没有初始化一个 late 变量，那么当变量被使用时会发生运行时错误
  print(description);
  // This is the program's only call to readThermometer().
 //late String temperature = readThermometer(); // Lazily initialized.

  //final
  final name = 'Bob'; // Without a type annotation
  final String nickname = 'Bobby';// 一个 final 变量只能设置一次
  //name = 'slice' // Error: a final variable can only be set once.
  //final 初始化后不能被修改

  //const
  const bar = 1000000; // Unit of pressure (dynes/cm2)
  const double atm = 1.01325 * bar; // Standard atmosphere

  var foo = const [];
  final bar1 = const [];
  const baz = []; // Equivalent to `const []`

  //baz = [42]; // Error: Constant variables can't be assigned a value.
  //不能修改const变量


  foo = [1, 2, 3]; // Was const []

  //定义常量时使用 类型检查和转换（is 和 as）、 集合中的 if 和 展开操作符（... 和 ...?）
  const Object i = 3; // Where i is a const Object with an int value...
  const list = [i as int]; // Use a typecast.
  const map = {if (i is int) i: 'int'}; // Use is and collection if.
  const set = {if (list is List<int>) ...list}; // ...and a spread.

  //虽然 final 对象不能被修改，但它的字段可能可以被更改。
  //相比之下，const 对象及其字段不能被更改：它们是 不可变的。

}

