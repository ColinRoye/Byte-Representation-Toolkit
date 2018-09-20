# plus-arbitrary-precision

[![Build Status](https://travis-ci.org/javiercejudo/plus-arbitrary-precision.svg)](https://travis-ci.org/javiercejudo/plus-arbitrary-precision)
[![Coverage Status](https://coveralls.io/repos/javiercejudo/plus-arbitrary-precision/badge.svg?branch=master)](https://coveralls.io/r/javiercejudo/plus-arbitrary-precision?branch=master)
[![Code Climate](https://codeclimate.com/github/javiercejudo/plus-arbitrary-precision/badges/gpa.svg)](https://codeclimate.com/github/javiercejudo/plus-arbitrary-precision)

Addition abstraction for [core-arbitrary-precision](https://github.com/javiercejudo/core-arbitrary-precision/)

## Install

    npm i plus-arbitrary-precision

## Adapters

- See [adapters](https://www.npmjs.com/browse/keyword/core-arbitrary-precision-adapter)

## Usage

```js
var adapter = require('floating-adapter');
var CoreDecimal = require('linear-arbitrary-precision')(adapter);
var Decimal = require('plus-arbitrary-precision')(CoreDecimal);

new Decimal('2').plus(new Decimal('3')).valueOf(); // => 5
```

See [spec](test/spec.js).
