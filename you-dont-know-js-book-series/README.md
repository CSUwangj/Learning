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
