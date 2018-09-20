/*jshint node:true */

'use strict';

var floatingFactory = require('floating');

module.exports = {
  getInstance: floatingFactory,
  getPrecision: getPrecision,
  setPrecision: setPrecision,
  plus: plus,
  minus: minus,
  times: times,
  div: div,
  mod: mod,
  pow: pow,
  sqrt: sqrt,
  equals: equals,
  gt: gt,
  gte: gte,
  lt: lt,
  lte: lte,
  cmp: cmp,
  abs: abs,
  toString: toString,
  valueOf: valueOf,
  parseInput: Number
};

// not necessarily true nor enforceable
var precision = 17;

function getPrecision() {
  return precision;
}

function setPrecision(Floating, n) {
  precision = n;
}

function plus(x, y) {
  return x.plus(y);
}

function minus(x, y) {
  return x.minus(y);
}

function times(x, y) {
  return x.times(y);
}

function div(x, y) {
  return x.div(y);
}

function mod(x, y) {
  return x.mod(y);
}

function pow(x, y) {
  return x.pow(y);
}

function sqrt(x, y) {
  return x.sqrt(y);
}

function equals(x, y) {
  return x.equals(y);
}

function lt(x, y) {
  return x.lt(y);
}

function lte(x, y) {
  return x.lte(y);
}

function gt(x, y) {
  return x.gt(y);
}

function gte(x, y) {
  return x.gte(y);
}

function cmp(x, y) {
  return x.cmp(y);
}

function abs(x, y) {
  return x.abs(y);
}

function toString(x) {
  return x.toString();
}

function valueOf(x) {
  return x.valueOf();
}
