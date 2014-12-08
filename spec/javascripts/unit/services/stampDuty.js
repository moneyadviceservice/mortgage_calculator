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

  describe('Stamp Duty Bands', function() {
    it('when house price is 0', function() {
      setPrice(0);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(0);
    });

    it('when house price is 125000', function() {
      setPrice(125000);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(125000);
    });

    it('when house price is 185000.00', function() {
      setPrice(185000);

      expect(stampDuty.cost()).toBe(1200.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(0.6, 1);
      expect(stampDuty.totalPurchase()).toBe(186200.00);
    });

    it('when house price is 275000', function() {
      setPrice(275000);

      expect(stampDuty.cost()).toBe(3750.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(1.4, 1);
      expect(stampDuty.totalPurchase()).toBe(278750);
    });

    it('when house price is 510000.00', function() {
      setPrice(510000.00);

      expect(stampDuty.cost()).toBe(15500.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(3, 1);
      expect(stampDuty.totalPurchase()).toBe(525500.00);
    });

    it('when house price is 937500', function() {
      setPrice(937500);

      expect(stampDuty.cost()).toBe(37500);
      expect(stampDuty.percentageTax()).toBeCloseTo(4, 1);
      expect(stampDuty.totalPurchase()).toBe(975000);
    });

    it('when house price is 2100000.00', function() {
      setPrice(2100000.00);

      expect(stampDuty.cost()).toBe(165750);
      expect(stampDuty.percentageTax()).toBeCloseTo(7.9, 1);
      expect(stampDuty.totalPurchase()).toBe(2265750.00);
    });
  });
});

