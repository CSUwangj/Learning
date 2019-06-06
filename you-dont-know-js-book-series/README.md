# Reading

## scope & closures

### Chapter 1

#### Ex 1.2.5

LHS查询：传参，**var b** = a, **var c** = foo(2).

RHS查询：b = **a**， return **a** + **b**，var c = **foo**(2)

### Chapter 2

- 全局变量会自动成为全局对象的属性，可以通过这种技术访问被隐藏的全局变量。但非全局变量如果被隐藏了就没法被访问到了。
- 严格模式中eval()无法修改所在的作用域。

### Chapter 3

```javascript
// 以下两者功能上一致
(function e(){console.log(2)})()
(function e(){console.log(2)}())

// 但以下不是
(() => {console.log(2)}()) // Uncaught SyntaxError: Unexpected token (
(() => {console.log(2)})() // 2

// 利用该方法倒置运行顺序，但坦白来说我个人觉得这个有点丑
(t = (e) => {e(window)})(f = (para) => { console.log(para)})

// 格式化一下
(t = (e) => {
    e(window)
})(f = (para) => {
    console.log(para)
})

// 然后名字搞个好听点的？
(function IIFE(f){
    f(window)
})(function def(para){
    console.log(para)
})

// 这样这段代码的意思就比较明白了，但是还是，，，
// 我觉得我写这样的代码会被 space 打死
// 等效代码如下（除了IIFE的特性外）

// 包库的时候这么用，但 window 一般放在后面

function notIIFE(f) {
    f(window)
}
function def(para) {
    console.log(para)
}
notIIFE(def)
```

利用块作用域来帮助GC（以下来自原文）:

```javascript
function process(data) {
    // do something interesting
}

var someReallyBigData = { .. };

process( someReallyBigData );

var btn = document.getElementById( "my_button" );

btn.addEventListener( "click", function click(evt){
    console.log("button clicked");
}, /*capturingPhase=*/false );
```

The click function click handler callback doesn't need the someReallyBigData
 variable at all. That means, theoretically, after process(..) runs, the big memory-
heavy data structure could be garbage collected. However, **it's quite likely
 (though implementation dependent) that the JS engine will still have to keep
 the structure around**, since the click function has a closure over the entire scope.

Block-scoping can address this concer

```javascript
function process(data) {
    // do something interesting
}

// anything declared inside this block can go away after!
{
    let someReallyBigData = { .. };

    process( someReallyBigData );
}

var btn = document.getElementById( "my_button" );

btn.addEventListener( "click", function click(evt){
    console.log("button clicked");
}, /*capturingPhase=*/false );
```

### Chapter 4

var、function造成的声明会被提升，并且函数先被提升（我感觉敢用这个特性也会被喷，起码我挺想喷的。。。）
函数声明会被提升，但是包括函数表达式在内的赋值操作就不会。

### Chapter 5

当函数可以记住并访问所在的词法作用域时，就产生了闭包。

```javascript
function makeFunc() {
  let name = 'Mozilla';
  function displayName() {
    console.log(name);
    name += ","
  }
  return displayName;
}

let myFunc = makeFunc();
myFunc();
```

[A *closure* is the combination of a function and the lexical environment within
 which that function was declared.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures)

利用闭包的特性完成模块化

```javascript
var makeCounter = function() {
  var privateCounter = 0;
  function changeBy(val) {
    privateCounter += val;
  }
  return {
    increment: function() {
      changeBy(1);
    },
    decrement: function() {
      changeBy(-1);
    },
    value: function() {
      return privateCounter;
    }
  }
};

var counter1 = makeCounter();
var counter2 = makeCounter();
alert(counter1.value()); /* Alerts 0 */
counter1.increment();
counter1.increment();
alert(counter1.value()); /* Alerts 2 */
counter1.decrement();
alert(counter1.value()); /* Alerts 1 */
alert(counter2.value()); /* Alerts 0 */
```

### Appendix A

词法作用域最重要的特征是它的定义过程发生在代码的书写阶段。

## this & object prototypes

### Chapter 1

this 并不指向函数自身，下面为反例：

```javascript
function foo(num) {
    console.log( "foo: " + num );

    // keep track of how many times `foo` is called
    this.count++;
}

foo.count = 0;

var i;

for (i=0; i<10; i++) {
    if (i > 5) {
        foo( i );
    }
}
// foo: 6
// foo: 7
// foo: 8
// foo: 9

// how many times was `foo` called?
console.log( foo.count ); // 0 -- WTF?
```

[感觉还是MDN比较清楚](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this)

### Chapter 2

四种绑定：

- 默认绑定。严格模式下，全局对象的this绑定到undefined，否则绑定到全局对象。

> in strict mode, if this was not defined by the execution context, it remains undefined.

```javascript
function f1() {
  return this;
}

// In a browser:
f1() === window; // true

// In Node:
f1() === global; // true

function f2() {
  'use strict'; // see strict mode
  return this;
}

f2() === undefined; // true
```

- 隐式绑定

this的上下文由调用位置决定，因此可能发生隐式绑定。对象属性引用链中中有最后一层会影响绑定位置。

```javascript
function foo() {
    console.log( this.a );
}

var obj2 = {
    a: 42,
    foo: foo
};

var obj1 = {
    a: 2,
    obj2: obj2
};

obj1.obj2.foo(); // 42
```

同时这种绑定可能因为传递丢失，这在回调函数中比较常见。

```javascript
function foo() {
    console.log( this.a );
}

var obj = {
    a: 2,
    foo: foo
};

var a = "oops, global"; // `a` also property on global object

setTimeout( obj.foo, 100 ); // "oops, global"
```

- 显式绑定

通过foo.call(...)、foo.apply(...)、foo.bind(...)进行绑定。

- new 绑定

以下为书里原文

```javascript
function foo(a) {
    this.a = a;
}

var bar = new foo( 2 );
console.log( bar.a ); // 2
```

By calling `foo(..)` with new in front of it, we've constructed a new object and
 set that new object as the `this` for the call of `foo(..)`. **So `new` is the
  final way that a function call's this can be bound. We'll call this new binding.**

可以用以下代码设置一个DMZ对象，使得“我希望this是空”的意图更明显

```javascript
var empty = Object.create(null)
```

### Chapter 3

> In objects, property names are always strings. If you use any other value
> besides a string (primitive) as the property, it will first be converted to a
> string. This even includes numbers, which are commonly used as array indexes,
> so be careful not to confuse the use of numbers between objects and arrays.

```javascript
var myObject = { };

myObject[true] = "foo";
myObject[3] = "bar";
myObject[myObject] = "baz";

myObject["true"];                // "foo"
myObject["3"];                   // "bar"
myObject["[object Object]"];     // "baz"
```

可以通过defineProperty(...)来添加属性并显示指定是否科协、是否可配置、是否可枚举。

### Chapter 4

### Chapter 5

```javascript
// 错误的写法
Bar.prototype = Foo.prototype

// 基本上满足需求，但是可能会产生副作用
Bar.prototype = new Foo()

// ES6前正确玩法
Bar.prototype = Object.create(Foo.prototype)

// ES6
Object.setPrototypeOf(Bar.prototype, Foo.prototype)
```

### Chapter 6

比较了一下JS中的面向对象模式和行为委托模式，感觉有点意思。

### Appendix A

class基本上只是现有**\[\[Prototype\]\]**机制的语法糖，因此有一下问题。

- 修改父类方法会影响所有已经实例化了的子类。（毕竟是是动态性语言www）
- 无法定义类成员属性。

## types & grammar

吐槽一下，，，中文版这什么排序啊，我还看到 up & going 在最后一本。。。

### Chapter 1

可以通过看 typeof 运算符返回是不是 undefined 来确认变量是否被定义而不用触发 Reference Error。（前提是它的值不为undefiend）

### Chapter 2

位运算只适用于32位整数，所以`a | 0`等价于`a & 0xFFFFFFFF`。（感觉会被打的trick）

### Chapter 3

### Chapter 4

 `parseInt(...)`会先进行toString()再转换，因此会有一些解释得通但是很奇怪的例子。不要写这样的代码，会被喷的。

`+`会调用valueOf()，String()调用ToString()。（所以写这么魔法肯定要被喷啊！！！）

`||`和`&&`返回的是操作数，即不是一定返回逻辑值，而是两个操作数中先和结果一致的值（这不还是魔法吗？？？)

也就是说

```javascript
a||b
// roughly equivalent to:
a ? a : b

a && b
// roughly equivalent to:
a ? b : a
```

不过上面这条用于初始化的时候貌似还挺有用的。形成共识的化的确OK吧。以及，以上两个运算符也有短路效果。

`==`允许在相等比较中进行强制类型转换，而`===`不允许。（别用`==`）

作者说

> Learn how to use the power of coercion (both explicit and implicit)
> effectively and safely. And teach those around you to do the same.

感觉很容易坑进去啊。。。

### Chapter 5

可以使用标签跳到外层循环。

其实没有else if，而只是相当于省略了一层花括号。。。

### Appendix A

网站的各自js文件、代码共享global对象（在浏览器中是window）。如果`<script> .. </script>`中的代码（无论内联或者外部）发生错误
，它会像独立程序那样停止，但是后续`<script> .. </script>`中的代码依然会接着运行。同时可以通过代码创建`<script> .. </script>`，并将其加入到页面的DOM中。

此外，浏览器根据代码文件的字符集属性解析外部文件的代码，内联代码则使用其所在页面的字符集。

## async & performance

### Chapter 1
