 'use strict';

describe('Service: StampDuty', function () {
  beforeEach(module('mortgageCalculatorApp'));

  var stampDuty,
      setPrice = function(price) {
        stampDuty.propertyPrice = price;
      },
      setSecondHome = function(isSecondHome) {
        stampDuty.isSecondHome = isSecondHome;
      };

  beforeEach(inject(function (StampDuty) {
    stampDuty = StampDuty;
    setPrice(260000);
  }));

  it('instantiates an instance of the service', function () {
    expect(!!stampDuty).toBe(true);
  });

  describe('Stamp Duty Bands - first/only home', function() {
    beforeEach(function () {
      setSecondHome(false);
    });

    it('when house price is 0', function() {
      setPrice(0);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(0);
    });

    it('when house price is 40000', function() {
      setPrice(40000);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(40000);
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

  describe('Stamp Duty Bands - second home', function() {
    beforeEach(function () {
      setSecondHome(true);
    });

    it('when house price is 0', function() {
      setPrice(0);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(0);
    });

    it('when house price is 40000', function() {
      setPrice(40000);

      expect(stampDuty.cost()).toBe(1200);
      expect(stampDuty.percentageTax()).toBeCloseTo(3, 1);
      expect(stampDuty.totalPurchase()).toBe(41200);
    });

    it('when house price is 125000', function() {
      setPrice(125000);

      expect(stampDuty.cost()).toBe(3750);
      expect(stampDuty.percentageTax()).toBeCloseTo(3, 1);
      expect(stampDuty.totalPurchase()).toBe(128750);
    });

    it('when house price is 185000.00', function() {
      setPrice(185000);

      expect(stampDuty.cost()).toBe(6750);
      expect(stampDuty.percentageTax()).toBeCloseTo(3.65, 2);
      expect(stampDuty.totalPurchase()).toBe(191750.00);
    });

    it('when house price is 275000', function() {
      setPrice(275000);

      expect(stampDuty.cost()).toBe(12000);
      expect(stampDuty.percentageTax()).toBeCloseTo(4.36, 2);
      expect(stampDuty.totalPurchase()).toBe(287000);
    });

    it('when house price is 510000.00', function() {
      setPrice(510000.00);

      expect(stampDuty.cost()).toBe(30800);
      expect(stampDuty.percentageTax()).toBeCloseTo(6.04, 2);
      expect(stampDuty.totalPurchase()).toBe(540800.00);
    });

    it('when house price is 937500', function() {
      setPrice(937500);

      expect(stampDuty.cost()).toBe(65625);
      expect(stampDuty.percentageTax()).toBeCloseTo(7.00, 2);
      expect(stampDuty.totalPurchase()).toBe(1003125.00);
    });

    it('when house price is 2100000.00', function() {
      setPrice(2100000.00);

      expect(stampDuty.cost()).toBe(228750);
      expect(stampDuty.percentageTax()).toBeCloseTo(10.89, 2);
      expect(stampDuty.totalPurchase()).toBe(2328750.00);
    });
  });
});

