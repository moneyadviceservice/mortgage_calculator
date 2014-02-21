'use strict';

describe('Service: StampDuty', function () {

  beforeEach(module('mortgageCalculatorApp'));


  var stampDuty,
      setPrice = function(price) {
        stampDuty.propertyPrice = price;
      };

  beforeEach(inject(function (StampDuty) {
    stampDuty = StampDuty;
    setPrice(260000);
  }));

  it('instantiates an instance of the service', function () {
    expect(!!stampDuty).toBe(true);
  });


  describe('#rate', function() {

    it('calculates the stamp duty percentage rate of a property price', function () {
      expect(stampDuty.rate()).toBe(0.03);
    });
  });

  describe('#cost', function() {

    it('calculates the stamp duty cost of a property price', function () {
      expect(stampDuty.cost()).toBe(7800);
    });
  });

  describe('#totalPurchase', function() {

    it('calculates the total purchase price of a property including the stamp duty cost', function () {
      expect(stampDuty.totalPurchase()).toBe(267800);
    });
  });

  describe('Stamp Duty Bands', function() {

    it('applies no stamp duty rate for properties less than £125000', function () {
      setPrice(120000);
      expect(stampDuty.rate()).toBe(0);
      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(120000);
    });

    it('applies a 1% rate for properties over £125000', function () {
      setPrice(126000);
      expect(stampDuty.rate()).toBe(0.01);
      expect(stampDuty.cost()).toBe(1260);
      expect(stampDuty.totalPurchase()).toBe(127260);
    });

    it('applies a 3% rate for properties over £250000', function () {
      setPrice(260000);
      expect(stampDuty.rate()).toBe(0.03);
      expect(stampDuty.cost()).toBe(7800);
      expect(stampDuty.totalPurchase()).toBe(267800);
    });

    it('applies a 4% rate for properties over £500000', function () {
      setPrice(510000);
      expect(stampDuty.rate()).toBe(0.04);
      expect(stampDuty.cost()).toBe(20400);
      expect(stampDuty.totalPurchase()).toBe(530400);
    });

    it('applies a 5% rate for properties over £1 million', function () {
      setPrice(1100000);
      expect(stampDuty.rate()).toBe(0.05);
      expect(stampDuty.cost()).toBe(55000);
      expect(stampDuty.totalPurchase()).toBe(1155000);
    });

    it('applies a 7% rate for properties over £2 million', function () {
      setPrice(1100000);
      expect(stampDuty.rate()).toBe(0.07);
      expect(stampDuty.cost()).toBe(147000);
      expect(stampDuty.totalPurchase()).toBe(2247000);
    });

  });





});
