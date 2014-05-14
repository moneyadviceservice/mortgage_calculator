'use strict';

describe('Service: Affordability', function () {

  beforeEach(module('mortgageCalculatorApp'));

  var affordability,
      resetApplicant2Income = function () {
        affordability.earnings.person2.annual = 0;
        affordability.earnings.person2.extra = 0;
        affordability.earnings.person2.net_pay = 0;
      },
      setIncome = function() {
        affordability.earnings.person1.annual = 50000;
        affordability.earnings.person1.extra = 3000;
        affordability.earnings.person1.net_pay = 3011;
        affordability.earnings.person2.annual = 30000;
        affordability.earnings.person2.extra = 1000;
        affordability.earnings.person2.net_pay = 1946;
      },
      setOutgoings = function() {
        affordability.outgoings.committed.credit_repayments = 300;
        affordability.outgoings.committed.childcare = 800;
        affordability.outgoings.fixed.child_maintenance = 200;
        affordability.outgoings.fixed.travel = 200;
        affordability.outgoings.fixed.utilities = 300;
        affordability.outgoings.fixed.rent_and_mortgage = 900;
        affordability.outgoings.lifestyle.entertainment = 1000;
        affordability.outgoings.lifestyle.holidays = 1000;
        affordability.outgoings.lifestyle.food = 140;
      };

  beforeEach(inject(function (Affordability) {
    affordability = Affordability;
    setIncome();
    setOutgoings();
  }));

  it('instantiates an instance of the service', function () {
    expect(!!affordability).toBe(true);
  });

  describe('#takeHomePay', function() {

    it('calculates the total take home pay of the applicant(s)', function () {
      expect(affordability.takeHomePay()).toBe(4957);
    });

  });

  describe('#committedCosts', function() {

    it('calculates the total committed costs of the applicant', function () {
      expect(affordability.committedCosts()).toBe(1100);
    });

  });

  describe('#minimumBorrowing', function() {

    it('calculates the minimum amount a single applicant can borrow', function () {
      resetApplicant2Income();
      expect(affordability.minimumBorrowing()).toBe(111440);
    });

    it('calculates the minimum amount two applicants can borrow', function () {
      expect(affordability.minimumBorrowing()).toBe(198240);
    });
  });

  describe('#maximumBorrowing', function() {

    it('calculates the maximum amount a single applicant can borrow', function () {
      resetApplicant2Income();
      expect(affordability.maximumBorrowing()).toBe(167160);
    });

    it('calculates the maximum amount two applicants can borrow', function () {
      expect(affordability.maximumBorrowing()).toBe(297360);
    });
  });



});
