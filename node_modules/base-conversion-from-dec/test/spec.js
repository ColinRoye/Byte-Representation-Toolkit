/*jshint node:true, mocha:true */

'use strict';

require('should');

var Big = require('arbitrary-precision')(require('bigjs-adapter'));
var toBigFactory = require('to-decimal-arbitrary-precision');

var fn = require('../src/');

describe('base conversion', function() {
  it('large decimal to base 9', function() {
    var d = toBigFactory(Big);

    Big.Impl.E_POS = 50;

    fn.big(d, 9, '5678364565345634563456346757364563534534645745')
      .should.be.exactly('802531310452364303450750087576673257456135727727');
  });

  it('decimal to base 62', function() {
    var decTo62 = fn(62);

    decTo62('60').should.be.exactly('y');
    decTo62(63).should.be.exactly('11');
  });

  it('custom decimal to binary', function() {
    var weirdDecToBin = fn.symbols('0987654321', 2);

    weirdDecToBin(91).should.be.exactly('90099');
  });

  it('should expose the raw converter', function() {
    var d = toBigFactory(Big);
    var weirdDecTo9 = fn.raw(d, '01234#6789', 9);

    Big.Impl.E_POS = 50;

    weirdDecTo9('#678364#6#34#634#634#63467#7364#63#34#3464#74#')
      .should.be.exactly('802#313104#23643034#07#0087#766732#74#613#727727');

    weirdDecTo9('#678364#6#3')
      .should.be.exactly('172#10402034');
  });

  it.skip('non-integer decimal to base 9', function() {
    fn(9, '10.10').should.be.exactly('11.08');
  });
});
