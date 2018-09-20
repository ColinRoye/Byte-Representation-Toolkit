# mod-arbitrary-precision

[![Build Status](https://travis-ci.org/javiercejudo/mod-arbitrary-precision.svg)](https://travis-ci.org/javiercejudo/mod-arbitrary-precision)
[![Coverage Status](https://coveralls.io/repos/javiercejudo/mod-arbitrary-precision/badge.svg?branch=master)](https://coveralls.io/r/javiercejudo/mod-arbitrary-precision?branch=master)
[![Code Climate](https://codeclimate.com/github/javiercejudo/mod-arbitrary-precision/badges/gpa.svg)](https://codeclimate.com/github/javiercejudo/mod-arbitrary-precision)

mod abstraction to extend [core-arbitrary-precision](https://github.com/javiercejudo/core-arbitrary-precision/)

## Install

    npm i mod-arbitrary-precision

## Adapters

- [[adapter]](https://github.com/javiercejudo/floating-adapter) [[lib]](https://github.com/javiercejudo/floating) floating

## Usage

```js
var adapter = require('floating-adapter');

var Decimal = require('mod-arbitrary-precision')(require('linear-arbitrary-precision')(adapter));

new Decimal('12').mod(new Decimal('5')).valueOf(); // => 2
```

See [spec](test/spec.js).
