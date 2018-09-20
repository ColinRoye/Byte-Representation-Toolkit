# div-arbitrary-precision

[![Build Status](https://travis-ci.org/javiercejudo/div-arbitrary-precision.svg)](https://travis-ci.org/javiercejudo/div-arbitrary-precision)
[![Coverage Status](https://coveralls.io/repos/javiercejudo/div-arbitrary-precision/badge.svg?branch=master)](https://coveralls.io/r/javiercejudo/div-arbitrary-precision?branch=master)
[![Code Climate](https://codeclimate.com/github/javiercejudo/div-arbitrary-precision/badges/gpa.svg)](https://codeclimate.com/github/javiercejudo/div-arbitrary-precision)

Division abstraction for [core-arbitrary-precision](https://github.com/javiercejudo/core-arbitrary-precision/)

## Install

    npm i div-arbitrary-precision

## Adapters

- See [adapters](https://www.npmjs.com/browse/keyword/core-arbitrary-precision-adapter)

## Usage

```js
var adapter = require('floating-adapter');
var CoreDecimal = require('linear-arbitrary-precision')(adapter);
var Decimal = require('div-arbitrary-precision')(CoreDecimal);

new Decimal('6').div(new Decimal('2')).valueOf(); // => 3
```

See [spec](test/spec.js).
