// 泛型就是解决 类 接口 方法的复用性、以及对不特定数据类型的支持(类型校验)
// 语法

Collection_name <data_type> identifier= new Collection_name<data_type>

// 三，使用泛型的好处
//
// 　　泛型是类型安全的（意思是你必须指定数据的类型），但是它的写法比硬编码指定类型高效的多：
//
// 类型安全
//
// 比如让数组只有String值，定义为List。这样，后续代码中，如果给数组赋值了非String类型，编译器将提示报错

var names = List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error

// 减少重复的代码　　
// 泛型让你通过一个单一类可以适配多种类型的数据操作，同时可以进行静态代码检查（比如，类型安全检查）。

abstract class ObjectCache {
Object getByKey(String key);
void setByKey(String key, Object value);
}

// 上面代码是对Object类型操作，在没用泛型的情况下，你想对String类型操作，就得重新定义一个类

abstract class StringCache {
String getByKey(String key);
void setByKey(String key, String value);
}

// 后面，你如果相对num类型操作，还得重新定义一个类。
//
// 而泛型就可以解决上面的问题，它通过对类型参数化，实现一个类针对多种数据类型操作的适配。

abstract class Cache<T> {
T getByKey(String key);
void setByKey(String key, T value);
}

// 四，Dart泛型的使用
//
// 使用集合
//
// List(通用列表)和map(通用映射)等字面量方式可以用指定类型参数。


var names = <String>['Seth', 'Kathy', 'Lars'];
var pages = <String, String>{
'index.html': 'Homepage',
'robots.txt': 'Hints for web robots',
'humans.txt': 'We are people, not machines'
};


//Set(通用集)和Queue(通用队列)等构造器方式可以用指定类型参数


void main() {
　　List <String> logTypes = new List <String>();
　　logTypes.add("WARNING");
　　logTypes.add("ERROR");
　　logTypes.add("INFO");

　　// iterating across list
　　for (String type in logTypes) {
　　　　print(type);
　　}
}



import 'dart:collection';
void main() {
　　Queue<int> queue = new Queue<int>();
print("Default implementation ${queue.runtimeType}");
queue.addLast(10);
queue.addLast(20);
queue.addLast(30);
queue.addLast(40);
queue.removeFirst();

for(int no in queue){
print(no);
}
}

// Dart的泛型类型是在运行时绑定的，这样，在运行时，可以知道List内具体类型

var names = List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true

// 注意：java中，泛型是采用擦除的方式，它在运行时，其实对象都是Object类型或者泛型的约束父类。
// 当泛型时，希望限制参数的类型范围，可以用extends关键字约束。


class Foo<T extends SomeBaseClass> {
// Implementation goes here...
String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {...}

//添加约束后，只要是指定的父类或者其子类都可以作为泛型参数。

var someBaseClassFoo = Foo<SomeBaseClass>();
var extenderFoo = Foo<Extender>();

//也可以不指定泛型参数。

var foo = Foo();
print(foo); // Instance of 'Foo<SomeBaseClass>'

//不可以用限定范围的泛型参数，这样静态代码检查器将提示错误。

var foo = Foo<Object>();


//下面是允许使用泛型方法的场景：

In the function’s return type (T).         //返回值
In the type of an argument (List).        //参数
In the type of a local variable (T tmp). //局部变量

T first<T>(List<T> ts) {
// Do some initial work or error checking, then...
T tmp = ts[0];
// Do some additional checking or processing...
return tmp;
}

//分类实现：同时支持返回 string类型 和int类型  （代码冗余）
String getData1(String value){
return value;
}

int getData2(int value){
return value;
}

//不确定类型：同时返回 string类型 和number类型  （放弃了类型检查）

getData(value){
return value;
}

//泛系处理：比如:传入number 类型必须返回number类型  传入 string类型必须返回string类型（即减少了代码冗余，又可以检查类型）
//返回T型
T getData<T>(T value){
return value;
}
//无返回值
getData<T>(T value){
return value;
}

　　void main(){
　　print(getData<int>(12));
　　}


//案例：把下面类转换成泛型类，要求List里面可以增加int类型的数据，也可以增加String类型的数据。但是每次调用增加的类型要统一

class PrintClass<T>{
List list=new List<T>();
void add(T value){
this.list.add(value);
}
void printInfo(){
for(var i=0;i<this.list.length;i++){
print(this.list[i]);
}
}
}

main() {
PrintClass p=new PrintClass<int>();
p.add(12);
p.add(23);
p.printInfo();
}

//泛型接口的用法

/*
        Dart中的泛型接口:
            实现数据缓存的功能：有文件缓存、和内存缓存。内存缓存和文件缓存按照接口约束实现。
            1、定义一个泛型接口 约束实现它的子类必须有getByKey(key) 和 setByKey(key,value)
            2、要求setByKey的时候的value的类型和实例化子类的时候指定的类型一致
        */

abstract class Cache<T>{
getByKey(String key);
void setByKey(String key, T value);
}

class FlieCache<T> implements Cache<T>{
@override
getByKey(String key) {
return null;
}

@override
void setByKey(String key, T value) {
print("我是文件缓存 把key=${key}  value=${value}的数据写入到了文件中");
}
}

class MemoryCache<T> implements Cache<T>{
@override
getByKey(String key) {
return null;
}

@override
void setByKey(String key, T value) {
print("我是内存缓存 把key=${key}  value=${value} -写入到了内存中");
}
}
void main(){
MemoryCache m=new MemoryCache<Map>();
m.setByKey('index', {"name":"张三","age":20});
}