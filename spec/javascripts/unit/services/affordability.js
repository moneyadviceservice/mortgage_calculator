'use strict';

describe('Service: Affordability', function () {

  beforeEach(module('mortgageCalculatorApp'));


  var affordability,
      resetApplicantTwoIncome = function () {
        affordability.earnings.personTwo.annual = 0;
        affordability.earnings.personTwo.extra = 0;
      };

  beforeEach(inject(function (Affordability) {
    affordability = Affordability;
    affordability.earnings.personOne.annual = 50000;
    affordability.earnings.personOne.extra = 1000;
    affordability.earnings.personTwo.annual = 30000;
    affordability.earnings.personTwo.extra = 1000;
  }));

  it('instantiates an instance of the service', function () {
    expect(!!affordability).toBe(true);
  });

  describe('#totalIncome', function() {

    it('calculates the total amount of income for a single applicant', function () {
      resetApplicantTwoIncome();
      expect(affordability.totalIncome()).toBe(51000);
    });

    it('calculates the total amount of income for two applicants', function () {
      expect(affordability.totalIncome()).toBe(82000);
    });

  });

  describe('#minimumBorrowing', function() {

    it('calculates the minimum amount a single applicant can borrow', function () {
      resetApplicantTwoIncome();
      expect(affordability.minimumBorrowing()).toBe(153000);
    });

    it('calculates the minimum amount two applicants can borrow', function () {
      expect(affordability.minimumBorrowing()).toBe(246000);
    });
  });

  describe('#maximumBorrowing', function() {

    it('calculates the maximum amount a single applicant can borrow', function () {
      resetApplicantTwoIncome();
      expect(affordability.maximumBorrowing()).toBe(204000);
    });

    it('calculates the maximum amount two applicants can borrow', function () {
      expect(affordability.maximumBorrowing()).toBe(328000);
    });
  });



});
