# base-conversion-from-dec

[![Build Status](https://travis-ci.org/javiercejudo/base-conversion-from-dec.svg)](https://travis-ci.org/javiercejudo/base-conversion-from-dec)
[![Coverage Status](https://coveralls.io/repos/javiercejudo/base-conversion-from-dec/badge.svg?branch=master)](https://coveralls.io/r/javiercejudo/base-conversion-from-dec?branch=master)
[![Code Climate](https://codeclimate.com/github/javiercejudo/base-conversion-from-dec/badges/gpa.svg)](https://codeclimate.com/github/javiercejudo/base-conversion-from-dec)

Auto-curried converter to any base with arbitrary precision support and customisable symbols.

For the opposite behaviour, see [base-conversion-to-dec](https://github.com/javiercejudo/base-conversion-to-dec).
For any to any base conversions, see [base-conversion](https://github.com/javiercejudo/base-conversion).

## Install

    npm i base-conversion-from-dec

## Basic usage

```js
var bc = require('base-conversion-from-dec');
var toBin = bc(2);

hexToBin('10'); //=> '1010'
hexToBin(30); //=> '11110'
```

See [spec](test/spec.js).

## Custom symbols

For any bases above 62, custom symbols are required.
See [tests](test/bigint-base-converter.js) for working examples.

```js
var bc = require('base-conversion-from-dec');

bc.symbols('⓿①②③④⑤⑥⑦⑧⑨ⒶⒷ', 12, '⑦③'); //=> '⑥①'
```

## Arbitrary precision

```js
var bc = require('base-conversion-from-dec');
var Big = require('arbitrary-precision')(require('bigjs-adapter'));
var toBigFactory = require('to-decimal-arbitrary-precision');

var d = toBigFactory(Big);

// avoid large numbers to go into exponential notation (adapter dependent)
Big.Impl.E_POS = 50;

bc.big(d, 9, '5678364565345634563456346757364563534534645745');
//=> '802531310452364303450750087576673257456135727727'
```

## Full raw version

```js
var bc = require('base-conversion-from-dec');
var Big = require('arbitrary-precision')(require('bigjs-adapter'));
var toBigFactory = require('to-decimal-arbitrary-precision');

var d = toBigFactory(Big);

// avoid large numbers to go into exponential notation (adapter dependent)
Big.Impl.E_POS = 50;

bc.raw(d, '01234#6789', 9, '#678364#6#34#634#634#63467#7364#63#34#3464#74#');
//=> '802#313104#23643034#07#0087#766732#74#613#727727'
```

## Defaults

The default symbols and big implementation are exposed as follows:

```js
bc.defaultSymbols; //=> '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
bc.defaultB; //=> default arbitrary precision implementation (div & mod)
```
