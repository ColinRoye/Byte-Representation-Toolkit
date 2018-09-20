# times-arbitrary-precision

[![Build Status](https://travis-ci.org/javiercejudo/times-arbitrary-precision.svg)](https://travis-ci.org/javiercejudo/times-arbitrary-precision)
[![Coverage Status](https://coveralls.io/repos/javiercejudo/times-arbitrary-precision/badge.svg?branch=master)](https://coveralls.io/r/javiercejudo/times-arbitrary-precision?branch=master)
[![Code Climate](https://codeclimate.com/github/javiercejudo/times-arbitrary-precision/badges/gpa.svg)](https://codeclimate.com/github/javiercejudo/times-arbitrary-precision)

Multiplication abstraction for [core-arbitrary-precision](https://github.com/javiercejudo/core-arbitrary-precision/)

## Install

    npm i times-arbitrary-precision

## Adapters

- See [adapters](https://www.npmjs.com/browse/keyword/core-arbitrary-precision-adapter)

## Usage

```js
var adapter = require('floating-adapter');
var CoreDecimal = require('linear-arbitrary-precision')(adapter);
var Decimal = require('times-arbitrary-precision')(CoreDecimal);

new Decimal('3').times(new Decimal('2')).valueOf(); // => 6
```

See [spec](test/spec.js).
