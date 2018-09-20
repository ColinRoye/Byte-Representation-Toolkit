/*jshint node:true, mocha:true */

'use strict';

require('should');

var Big = require('arbitrary-precision')(require('bigjs-adapter'));
var toBigFactory = require('to-decimal-arbitrary-precision');
var d = toBigFactory(Big);

Big.Impl.E_POS = 40;

var symbols85 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&()*+-;<=>?@^_`{|}~';

var other = require('bigint-base-converter');
var fn = require('../src/');

describe('bigint-base-converter', function() {
  it('yields the same results for base 16', function() {
    var b10To16 = fn.big(d, 16);

    '108000000000000000080800200C417A'
      .should.be.exactly(other('21932261930451111902915077091070067066', '0123456789', '0123456789ABCDEF'))
      .and.exactly(b10To16('21932261930451111902915077091070067066'));
  });

  it('yields the same results from 10 to 85', function() {
    var b10To85 = fn.raw(d, symbols85, 85);

    '4)+k&C#VzJ4br>0wv%Yp'
      .should.be.exactly(other('21932261930451111902915077091070067066', '0123456789', symbols85))
      .and.exactly(b10To85('21932261930451111902915077091070067066'));
  });
});
