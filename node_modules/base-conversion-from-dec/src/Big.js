/*jshint node:true */

'use strict';

var coreArbitraryPrecision = require('core-arbitrary-precision');
var floatingAdapter = require('floating-adapter');
var pipe = require('ramda/src/pipe');

module.exports = pipe(
  require('div-arbitrary-precision'),
  require('mod-arbitrary-precision')
)(coreArbitraryPrecision(floatingAdapter));
