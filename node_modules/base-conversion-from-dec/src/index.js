/*jshint node:true */

'use strict';

var posNotation = require('positional-notation');
var toBigFactory = require('to-decimal-arbitrary-precision');

var R = require('./R');

var defaultB = toBigFactory(require('./Big'));
var defaultSymbols = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
var joinWithoutSep = R.join('');
var toString = R.invoker(0, 'toString');

var indexOfSymbol = R.memoize(function(symbols) {
  return R.memoize(R.indexOf(R.__, symbols));
});

var nthSymbol = R.memoize(function(symbols) {
  return R.memoize(R.nth(R.__, symbols));
});

var preprocess = R.memoize(function(symbols) {
  return R.identical(symbols, defaultSymbols) ?
    R.identity :
    R.pipe(
      toString,
      R.map(indexOfSymbol(symbols)),
      joinWithoutSep
    );
});

var fromDecimalRaw = R.curryN(4, function(b, symbols, base, n) {
  return R.pipe(
    preprocess(symbols),
    R.unfold(posNotation.unfolder(b, base)),
    R.map(nthSymbol(symbols)),
    R.reverse,
    joinWithoutSep
  )(n);
});


var fromDecimal = fromDecimalRaw(defaultB, defaultSymbols);

fromDecimal.big = fromDecimalRaw(R.__, defaultSymbols);
fromDecimal.symbols = fromDecimalRaw(defaultB);
fromDecimal.raw = fromDecimalRaw;

fromDecimal.defaultSymbols = defaultSymbols;
fromDecimal.defaultB = defaultB;

module.exports = fromDecimal;
