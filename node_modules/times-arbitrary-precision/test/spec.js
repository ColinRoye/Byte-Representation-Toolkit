/*jshint node:true, mocha:true */

'use strict';

require('should');

var adapter = require('floating-adapter');
var Decimal = require('core-arbitrary-precision')(adapter);

Decimal = require('../src/')(Decimal);

describe('times', function() {
  it('should multiply a given number', function() {
    new Decimal('3').times(new Decimal('2')).toString().should.be.exactly('6');
  });
});
