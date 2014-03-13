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
      expect(repayments.monthlyRepayment()).toBe(2630.66);
    });

  });

  describe('#monthlyInterestRepayment', function() {

    it('calculates the monthly interest only repayment for a mortgage', function () {
      expect(repayments.monthlyInterestRepayment()).toBe(1875.00);
    });

  });



});
