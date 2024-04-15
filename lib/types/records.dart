// 记录是一种匿名的、不可变的聚合类型。
//
//
// 1. 记录类型的声明与访问
//
// 通过 () 将若干个对象组合在一块，作为一个新的聚合类型。定义时可以直接当放入对象，也可以进行命名传入：

var record = ('first', a: 2, b: true, 'last');
print(record.runtimeType);

//--->[打印输出]---
(String, String, {int a, bool b})

// 上面的 record 对象由四个数据构成，通过 runtimeType 可以查看到其运行时类型，类型为各个非命名数据类型 + 各命名类型。
//
// 非命名类型数据可以通过 $index 进行访问：


print(record.$1);
print(record.$2);

//--->[打印输出]---
first
last

//命名类型数据可以通过 名称 进行访问：


print(record.a);
print(record.b);

//--->[打印输出]---

true

//注意: 一个记录对象的数据不允许被修改:

// 2. 记录类型声明对象
//
// 一个 Records 本质上也是一种类型，可以用该类型来声明对象，比如现在通过 (double,double,double) 的记录类型表示三个坐标，如下定义 p0 和 p1 对象：

void main() {
(double x, double y, double z) p0 = (1, 2, 3);
(double x, double y, double z) p1 = (1, 2, 6);
}

// 既然可以实例化为对象，那么自然也可以将其作为参数类型传入函数中，如下 distance 方法传入两个三维点，计算距离：

double distance(
(double x, double y, double z) p0,
(double x, double y, double z) p1,
) {
num result = pow(p0.$1 - p1.$1, 2) + pow(p0.$2 - p1.$2, 2) + pow(p0.$3 - p1.$3, 2);
return sqrt(result);
}

// 但记录类型一旦显示声明，写起来比较繁琐；和函数类型类似，也可以通过 typedef 来定义类型的别名。如下所示，
// 定义 Point3D 作为别名，功能是等价的，但书写和可读性会更好一些：

typedef Point3D = (double, double, double);

void main() {
Point3D p0 = (1, 2, 3);
Point3D p1 = (1, 2, 6);

print(distance(p0, p1));
}

double distance(Point3D p0, Point3D p1) {
num result = pow(p0.$1 - p1.$1, 2) + pow(p0.$2 - p1.$2, 2) + pow(p0.$3 - p1.$3, 2);
return sqrt(result);
}

// 同理，记录类型也可以作为返回值，这样可以解决一个函数返回多值的问题。如下 addTask 方法可以计算 1 ~ count 的累加值，返回计算结果和耗时毫秒数：

({int result, int cost}) addTask2(int count) {
int start = DateTime.now().millisecondsSinceEpoch;
int sum = 0;
for (int i = 0; i < count; i++) {
sum += i;
}
int end = DateTime.now().millisecondsSinceEpoch;
return (
result: sum,
cost: end - start,
);
}

// 3. 记录类型对象的等值
//
// 记录类型会根据字段的结构自动定义 hashCode 和 == 方法。 所以两个记录对象相等，就是其中的各个数值相等。但是通过 identical 可以看出 p0 和 p1 仍是两个对象，内存地址不同：

(double, double, double) p0 = (1, 2, 3);
(double, double, double) p1 = (1, 2, 3);
print(p0 == p1);
print(identical(p0, p1));

// --->[打印输出]---
true
false

// 如下所示，第二个数据是 List<double> 类型，两个 [2] 是两个不同的对象，所以 p2，p3 不相等：

(double, List<double>, double) p2 = (1, [2], 3);
(double, List<double>, double) p3 = (1, [2], 3);
print(p2==p3);

// --->[打印输出]---
false

// 下面测试中， 列表使用同一对象，则 p2，p3 相等：

List<double> li = [2];
(double, List<double>, double) p2 = (1, li, 3);
(double, List<double>, double) p3 = (1, li, 3);
print(p2==p3);

// --->[打印输出]---
true

// 4. 记录类型的价值
//
// 对于编程语言来说，Dart 的记录类型也不是什么新的东西，就是其他语言中的元组。如下所示，可以创建一个 TaskResult 类来维护
// 数据作为返回值。但如果只是返回一些临时的数据，为此新建一个类来维护数据就会显得比较繁琐，还要定义构造函数。

class TaskResult{
final int result;
final int cost;

TaskResult(this.result, this.cost);
}

TaskResult addTask(int count) {
int start = DateTime.now().millisecondsSinceEpoch;
int sum = 0;
for (int i = 0; i < count; i++) {
sum += i;
}
int end = DateTime.now().millisecondsSinceEpoch;
return TaskResult(sum, end - start);
}

//除此之外，一个函数返回多个数据也可以使用 Map 对象：

Map<String,dynamic> addTask(int count) {
int start = DateTime.now().millisecondsSinceEpoch;
int sum = 0;
for (int i = 0; i < count; i++) {
sum += i;
}

int end = DateTime.now().millisecondsSinceEpoch;
return {
'result' : sum,
'cost': end - start
};
}

//但这种方式的弊端也很明显，返回和使用时都需要固定的字符串作为 key。如果 key 写错了，代码在运行前也不会有任何错误，这样很容易出现风险。多人协作时，而且如果函数的书写者和调用者不是一个人，那该使用什么键得到什么值就很难分辨。

Map<String,dynamic> task = addTask2(100000000);
print(task['result']);
print(task['cost']);
//
// 所以，相比于新建 class 或通过 Map 来维护多个数据，使用记录类型更加方便快捷和精确。但话说回来，如果属性数据量过多，使用记录类型看起来会非常麻烦，
// 也不能定义成员方法来操作、修改内部数据。所以它有自己的特点使用场景，比如临时聚合多个数据来方便使用。