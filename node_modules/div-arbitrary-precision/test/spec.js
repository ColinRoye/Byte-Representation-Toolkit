/*jshint node:true, mocha:true */

'use strict';

require('should');

var adapter = require('floating-adapter');
var Decimal = require('core-arbitrary-precision')(adapter);

Decimal = require('../src/')(Decimal);

describe('div', function() {
  it('should divide by a given number', function() {
    new Decimal('6').div(new Decimal('2')).toString().should.be.exactly('3');
  });
});
