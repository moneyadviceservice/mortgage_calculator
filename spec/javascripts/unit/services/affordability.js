'use strict';

describe('Service: Affordability', function() {

  beforeEach(module('mortgageCalculatorApp'));

  var affordability,
    repayments,
    resetApplicant2Income = function() {
      affordability.earnings.person1.annual = 0;
      affordability.earnings.person1.extra = 0;
      affordability.earnings.person1.net_pay = 0;
    },
    setIncome = function() {
      affordability.earnings.person0.annual = 50000;
      affordability.earnings.person0.extra = 3000;
      affordability.earnings.person0.net_pay = 3011;
      affordability.earnings.person1.annual = 30000;
      affordability.earnings.person1.extra = 1000;
      affordability.earnings.person1.net_pay = 1946;
    },
    setOutgoings = function() {
      affordability.outgoings.credit_repayments = 300;
      affordability.outgoings.childcare = 800;
      affordability.outgoings.child_maintenance = 200;
      affordability.outgoings.travel = 200;
      affordability.outgoings.utilities = 300;
      affordability.outgoings.rent_and_mortgage = 900;
      affordability.outgoings.entertainment = 1000;
      affordability.outgoings.holidays = 1000;
      affordability.outgoings.food = 140;
    },
    calculateRepayments = function() {
      repayments.propertyPrice = affordability.borrowing();
    };

  beforeEach(inject(function(Affordability, Repayments) {
    affordability = Affordability;
    repayments = Repayments;
    setIncome();
    setOutgoings();
  }));

  it('instantiates an instance of the service', function() {
    expect( !! affordability).toBe(true);
  });

  describe('#minimumBorrowing', function() {

    it('calculates the minimum amount a single applicant can borrow', function() {
      resetApplicant2Income();
      expect(affordability.minimumBorrowing()).toBe(131600);
    });

    it('calculates the minimum amount two applicants can borrow', function() {
      expect(affordability.minimumBorrowing()).toBe(218400);
    });
  });

  describe('#maximumBorrowing', function() {

    it('calculates the maximum amount a single applicant can borrow', function() {
      resetApplicant2Income();
      expect(affordability.maximumBorrowing()).toBe(197400);
    });

    it('calculates the maximum amount two applicants can borrow', function() {
      expect(affordability.maximumBorrowing()).toBe(327600);
    });
  });

  describe('#borrowing', function() {

    it('calculates the median value between the minimum and maximum borrowing offered', function() {
      expect(affordability.borrowing()).toBe(273000);
    });

  });

  describe('Repayments', function() {

    it('calculates the monthly repayments of the borrowing', function() {
      calculateRepayments();
      expect(affordability.monthlyRepayment()).toBe(1595.93);
    });

  });

  describe('#takeHomePay', function() {

    it('calculates the total take home pay of the applicant(s)', function() {
      expect(affordability.takeHomePay()).toBe(4957);
    });

  });

  describe('#committedCosts', function() {

    it('calculates the total committed costs of the applicant(s)', function() {
      expect(affordability.committedCosts()).toBe(500);
    });

  });

  describe('#calculateLifestyleSpend', function() {

    it('calculates the total lifestyle spend of the applicant(s)', function() {
      expect(affordability.calculateLifestyleSpend()).toBe(2140);
    });

  });

  describe('#remainingPerMonth', function() {

    it('calculates the remaining spend per month minus all the key costs of the applicant(s)', function() {
      affordability.lifestyleSpend = affordability.calculateLifestyleSpend();
      expect(affordability.remainingPerMonth()).toBe(1017);
    });

  });

});
