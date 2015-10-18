A light introduction to
Functional Programming
==============================

`k => {k: v} => {k: v} => Boolean`



What is FP?
-----------

- A focus on functions as the basic building block <!-- .element: class="fragment" -->
- Functions that take other functions as arguments <!-- .element: class="fragment" -->
- Functions that return other functions <!-- .element: class="fragment" -->
- Pure <!-- .element: class="fragment" -->
  - Same inputs give the same outputs (don't rely on outside state) <!-- .element: class="fragment" -->
  - No side-effects! (mutating state, calling other api's) <!-- .element: class="fragment" -->



Why FP?
--------

- Robust - predictable, flexible, and less buggy <!-- .element: class="fragment" -->
- Easy to read and reason about - "What" not "how" <!-- .element: class="fragment" -->
- Separate behavior from data <!-- .element: class="fragment" -->
- Build complexity through composition of simple, reusable units <!-- .element: class="fragment" -->



Under the hood
--------------------


### Common examples

- `map`
- `bind` (aka `partial`)


### `Map`

```
function map (fn, list) {
  let results = [];
  for (let i = 0; i < list.length; i++) {
    results.push(fn(list[i], i));
  }
  return results;
}
```


### Benefits
- Lets us focus on concepts ("map", "filter", "reduce") rather than implementation

```
let cardinalDegs = [0, 90, 180, 360];
let cardinalRads = map(MathLib.degToRad, cardinalDegs);
```


### `Partial`

```
function partial (fn, ...boundArgs) {
  return (...calledArgs) => {
    return fn.apply(null, [...boundArgs, ...calledArgs]);
  };
}
```


### Benefits
- Lets us build up reusable behavior
- Separates defining behavior from applying our data

```
let getProp = (prop, obj) => obj[prop];
let getAge = partial(getProp, 'age');
let getAges = partial(map, getAge);

let people = [
  {name: "Joe", age: 31},
  {name: "Jack", age: 32},
  {name: "Jim", age: 29}
];
let ages = getAges(people);
```



FP in practice
--------------
(with good ol' javascript) <!-- .element: class="fragment" -->


### [Ramda.js](http://ramdajs.com/0.18.0/index.html)

![ramda](http://ramda.jcphillipps.com/logo/ramdaFilled_200x235.png)

- Practical and performant
- Supports and encourages composition
  - Data last!
  - Auto-curried
  - [Hey Underscore, You're Doing It Wrong!](https://www.youtube.com/watch?v=m3svKOdZijA) <!-- .element: class="fragment" -->


Composition
-----------

- Passing the output of one function as the argument for another
- Like unix's `pipe`

```
let fgh = (x) => {
  f(g(h(x)));
};
fgx(x);
```
<!-- .element: class="fragment" -->


### With ramda

```
let fgh = R.compose(f,g,h);
fgh(x);
```

(pro tip - read from right to left, bottom to top)

Bonus points for being "points-free"
<!-- .element: class="fragment" -->
- Function definitions do not identify the arguments (or "points") on which they operate
- In other words, you don't see the `(...) => {...}` syntax (less clutter)

<!-- .element: class="fragment" -->


Currying
--------

- The ability to call a function one argument at a time
- Like partial application, but repeatable

```
let add3Things = (a, b, c) =>  a + b + c ;
let six = add3Things(1, 2, 3);

let curriedAdd3Things = R.curry(add3Things);

let six = curriedAdd3Things(1)(2)(3);
// or
let onePlusTwoMoreThings = curriedAdd3Things(1);
let threePlusOneMoreThing = onePlusTwoMoreThings(2);
let six = threePlusOneMoreThing(3);
```



A practical example
-------------------

```
let people = [
  {name: "Joe", age: 31},
  {name: "Jack", age: 32},
  {name: "Jim", age: 29}
];

let getAges = R.map(R.prop('age')):
let ages = getAges(people); // [31, 32, 29]
```


What is the oldest age?
```
let getOldest = R.compose(R.max, getAges);
let oldest = getOldest(people); // 32
```


Who is under 30?
```
let isUnder30 = R.compose(R.gt(30), R.prop('age'));
let peopleUnder30 = R.compose(
  R.map(R.prop('name')),
  R.filter(isUnder30)
)(people); // ['Jim']
```



FP notation
-----------

So what does this mean:

`k => {k: v} => {k: v} => Boolean`

A function that takes a key, then one object, then another object, and returns a boolean.
<!-- .element: class="fragment" -->

Aka `R.eqProps` - Do two objects have the same value for a given key?

<!-- .element: class="fragment" -->



Now go play!
-----------
http://ramdajs.com/repl/
<iframe src="http://ramdajs.com/repl/" width="100%" height="500">
