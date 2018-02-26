 'use strict';

describe('Service: StampDuty', function () {
  beforeEach(module('mortgageCalculatorApp'));

  var stampDuty,
      setPrice = function(price) {
        stampDuty.propertyPrice = price;
      },
      setSecondHome = function(isSecondHome) {
        stampDuty.isSecondHome = isSecondHome;
      },
      setBuyerType = function(buyerType) {
        stampDuty.buyerType = buyerType;
      };
  window.calculator_config = {
    "standard":[
      {"threshold":125000,"rate":0},
      {"threshold":250000,"rate":2},
      {"threshold":925000,"rate":5},
      {"threshold":1500000,"rate":10},
      {"threshold":null,"rate":12}
    ],
    "ftb":[
      {"threshold":300000,"rate":0},
      {"threshold":500000,"rate":5}
    ],
    "second_home_tax_rate":3,
    "second_home_threshold":40000,
    "first_time_buyer_threshold":500000
  }

  beforeEach(inject(function (StampDuty) {
    stampDuty = StampDuty;
    setPrice(260000);
  }));

  it('instantiates an instance of the service', function () {
    expect(!!stampDuty).toBe(true);
  });

  describe('Stamp Duty Bands - First time buyer', function() {
    beforeEach(function () {
      setBuyerType('isFTB');
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

    it('when house price is 260000', function() {
      setPrice(250000);

      expect(stampDuty.cost()).toBe(0);
      expect(stampDuty.percentageTax()).toBe(0);
      expect(stampDuty.totalPurchase()).toBe(250000);
    });

    it('when house price is 350000', function() {
      setPrice(350000);

      expect(stampDuty.cost()).toBe(2500);
      expect(stampDuty.percentageTax()).toBeCloseTo(0.71, 2);
      expect(stampDuty.totalPurchase()).toBe(352500);
    });

    it('when house price is 400012', function() {
      setPrice(400012);

      expect(stampDuty.cost()).toBe(5000);
      expect(stampDuty.percentageTax()).toBeCloseTo(1.25, 2);
      expect(stampDuty.totalPurchase()).toBe(405012);
    });

    it('when house price is 450000', function() {
      setPrice(450000);

      expect(stampDuty.cost()).toBe(7500);
      expect(stampDuty.percentageTax()).toBeCloseTo(1.67, 2);
      expect(stampDuty.totalPurchase()).toBe(457500);
    });

    it('when house price is 550000', function() {
      setPrice(550000);

      expect(stampDuty.cost()).toBe(17500);
      expect(stampDuty.percentageTax()).toBeCloseTo(3.18, 2);
      expect(stampDuty.totalPurchase()).toBe(567500);
    });
  });

  describe('Stamp Duty Bands - Only home', function() {
    beforeEach(function () {
      setBuyerType('isNextHome');
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
      expect(stampDuty.percentageTax()).toBeCloseTo(0.65, 2);
      expect(stampDuty.totalPurchase()).toBe(186200.00);
    });

    it('when house price is 275000', function() {
      setPrice(275000);

      expect(stampDuty.cost()).toBe(3750.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(1.36, 2);
      expect(stampDuty.totalPurchase()).toBe(278750);
    });

    it('when house price is 300019', function() {
      setPrice(300019);

      expect(stampDuty.cost()).toBe(5000.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(1.67, 2);
      expect(stampDuty.totalPurchase()).toBe(305019);
    });

    it('when house price is 510000.00', function() {
      setPrice(510000.00);

      expect(stampDuty.cost()).toBe(15500.00);
      expect(stampDuty.percentageTax()).toBeCloseTo(3.04, 2);
      expect(stampDuty.totalPurchase()).toBe(525500.00);
    });

    it('when house price is 937500', function() {
      setPrice(937500);

      expect(stampDuty.cost()).toBe(37500);
      expect(stampDuty.percentageTax()).toBeCloseTo(4.00, 2);
      expect(stampDuty.totalPurchase()).toBe(975000);
    });

    it('when house price is 2100000.00', function() {
      setPrice(2100000.00);

      expect(stampDuty.cost()).toBe(165750);
      expect(stampDuty.percentageTax()).toBeCloseTo(7.89, 2);
      expect(stampDuty.totalPurchase()).toBe(2265750.00);
    });
  });

  describe('Stamp Duty Bands - second home', function() {
    beforeEach(function () {
      setBuyerType('isSecondHome');
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
      expect(stampDuty.percentageTax()).toBeCloseTo(3.00, 2);
      expect(stampDuty.totalPurchase()).toBe(41200);
    });

    it('when house price is 125000', function() {
      setPrice(125000);

      expect(stampDuty.cost()).toBe(3750);
      expect(stampDuty.percentageTax()).toBeCloseTo(3.00, 2);
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

    it('when house price is 988882', function() {
      setPrice(988882);

      expect(stampDuty.cost()).toBe(72304);
      expect(stampDuty.percentageTax()).toBeCloseTo(7.31, 2);
      expect(stampDuty.totalPurchase()).toBe(1061186);
    });

    it('when house price is 2100000.00', function() {
      setPrice(2100000.00);

      expect(stampDuty.cost()).toBe(228750);
      expect(stampDuty.percentageTax()).toBeCloseTo(10.89, 2);
      expect(stampDuty.totalPurchase()).toBe(2328750.00);
    });
  });
});
