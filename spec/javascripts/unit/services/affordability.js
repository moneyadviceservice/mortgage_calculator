'use strict';

describe('Service: Affordability', function () {

  // load the service's module
  beforeEach(module('mortgageCalculatorApp'));

  // instantiate service
  var affordability,
  // Utility function to isolate tests to single applicant
      resetApplicantTwoIncome = function () {
        affordability.personTwoAnnualIncome = 0;
        affordability.personTwoExtraIncome = 0;
      };

  beforeEach(inject(function (Affordability) {
    affordability = Affordability;
    affordability.annualIncome = 50000;
    affordability.extraIncome = 1000;
    affordability.personTwoAnnualIncome = 30000;
    affordability.personTwoExtraIncome = 1000;
  }));

  it('should instantiate an instance of the service', function () {
    expect(!!affordability).toBe(true);
  });

  describe('#totalIncome', function() {

    it('should calculate the total amount of income for a single applicant', function () {
      resetApplicantTwoIncome();
      expect(affordability.totalIncome()).toBe(51000);
    });

    it('should calculate the total amount of income for two applicants', function () {
      expect(affordability.totalIncome()).toBe(82000);
    });

  });

  describe('#minimumBorrowing', function() {

    it('should calculate the minimum amount a single applicant can borrow', function () {
      resetApplicantTwoIncome();
      expect(affordability.minimumBorrowing()).toBe(153000);
    });

    it('should calculate the minimum amount two applicants can borrow', function () {
      expect(affordability.minimumBorrowing()).toBe(246000);
    });
  });

  describe('#maximumBorrowing', function() {

    it('should calculate the maximum amount a single applicant can borrow', function () {
      resetApplicantTwoIncome();
      expect(affordability.maximumBorrowing()).toBe(204000);
    });

    it('should calculate the maximum amount two applicants can borrow', function () {
      expect(affordability.maximumBorrowing()).toBe(328000);
    });
  });



});
