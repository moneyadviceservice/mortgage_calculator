'use strict';

describe('Service: Affordability', function () {

  // load the service's module
  beforeEach(module('mortgageCalculatorApp'));

  // instantiate service
  var affordability;
  beforeEach(inject(function ($injector) {
    affordability = $injector.get('Affordability');
    affordability.annualIncome = 20000;
    affordability.extraIncome = 1000;
    affordability.personTwoAnnualIncome = 20000;
    affordability.personTwoExtraIncome = 1000;
  }));

  it('should instantiate an instance of the service', function () {
    expect(!!affordability).toBe(true);
  });

  describe('#calculateTotalIncome', function() {

    it('should calculate the total amount of income for a single applicant', function () {
      expect(affordability.calculateTotalIncome()).toBe(21000);
    });

    it('should calculate the total amount of income for two applicants', function () {
      expect(affordability.calculateTotalIncome()).toBe(42000);
    });

  });

  describe('#calculateTotalBorrowing', function() {

    it('should calculate the total amount a single applicant can borrow', function () {
      expect(affordability.calculateTotalBorrowing()).toBe(94500);
    });

    it('should calculate the total amount two applicants can borrow', function () {
      expect(affordability.calculateTotalBorrowing()).toBe(189000);
    });

  });



});
