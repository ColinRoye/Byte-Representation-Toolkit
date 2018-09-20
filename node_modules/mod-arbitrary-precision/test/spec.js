/*jshint node:true, mocha:true */

'use strict';

require('should');

var adapter = require('floating-adapter');
var Decimal = require('core-arbitrary-precision')(adapter);

Decimal = require('../src/')(Decimal);

describe('sqrt', function() {
  it('should give the remainder of the division', function() {
    new Decimal('12').mod(new Decimal('5')).valueOf().should.be.exactly(2);
  });
});
