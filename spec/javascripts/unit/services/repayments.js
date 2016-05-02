'use strict';

describe('Service: Repayments', function () {

  beforeEach(module('mortgageCalculatorApp'));


  var repayments,
      setMortgage = function(price, deposit) {
        repayments.propertyPrice = price;
        repayments.deposit = deposit;
      };

  beforeEach(inject(function (Repayments) {
    repayments = Repayments;
    setMortgage(500000, 50000);
  }));

  it('instantiates an instance of the service', function () {
    expect(!!repayments).toBe(true);
  });

  describe('#mortgage', function() {

    it('calculates the total mortgage for an applicant', function () {
      expect(repayments.mortgage()).toBe(450000);
    });

  });

  describe('#monthlyRepayment', function() {

    it('calculates the monthly repayment for a mortgage', function () {
      expect(repayments.monthlyRepayment()).toBe(2133.95);
    });

    it('calculates the monthly repayment for a mortgage when interest incremented by one', function () {
      expect(repayments.monthlyRepayment(1)).toBe(2375.27);
    });

    it('returns 0 for negative results', function () {
      setMortgage(1, 50000);
      expect(repayments.monthlyRepayment()).toBe(0);
    });



  });

  describe('#monthlyInterestRepayment', function() {

    it('calculates the monthly interest only repayment for a mortgage', function () {
      expect(repayments.monthlyInterestRepayment()).toBe(1125.00);
    });

    it('calculates the monthly interest only repayment for a mortgage when interest is incremented by one', function () {
      expect(repayments.monthlyInterestRepayment(1)).toBe(1500.00);
    });

    it('returns 0 for negative results', function () {
      setMortgage(1, 50000);
      expect(repayments.monthlyInterestRepayment()).toBe(0);
    });

  });



});
