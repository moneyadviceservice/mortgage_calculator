'use strict';

describe('Service: Affordability', function() {

  beforeEach(module('mortgageCalculatorApp'));

  var affordability,
    repayments,
    resetApplicantIncome = function(person) {
      affordability.earnings['person' + person].annual = 0;
      affordability.earnings['person' + person].extra = 0;
      affordability.earnings['person' + person].net_pay = 0;
    },
    setIncome = function() {
      affordability.earnings.person0.annual = 40000;
      affordability.earnings.person0.extra = 0;
      affordability.earnings.person0.net_pay = 2512.89;
      affordability.earnings.person1.annual = 35000;
      affordability.earnings.person1.extra = 0;
      affordability.earnings.person1.net_pay = 2229.56;
    },
    setOutgoings = function() {
      affordability.outgoings.credit_repayments = 300;
      affordability.outgoings.childcare = 0;
      affordability.outgoings.child_maintenance = 0;
      affordability.outgoings.travel = 600;
      affordability.outgoings.utilities = 325;
      affordability.outgoings.rent_and_mortgage = 900;
      affordability.outgoings.entertainment = 400;
      affordability.outgoings.holidays = 300;
      affordability.outgoings.food = 0;
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
      resetApplicantIncome(2);
      expect(affordability.minimumBorrowing()).toBe(101920);
    });

    it('calculates the minimum amount two applicants can borrow', function() {
      expect(affordability.minimumBorrowing()).toBe(199920);
    });
  });

  describe('#maximumBorrowing', function() {

    it('calculates the maximum amount a single applicant can borrow', function() {
      resetApplicantIncome(2);
      expect(affordability.maximumBorrowing()).toBe(152880);
    });

    it('calculates the maximum amount two applicants can borrow', function() {
      expect(affordability.maximumBorrowing()).toBe(299880);
    });
  });

  describe('#borrowing', function() {

    it('calculates the median value between the minimum and maximum borrowing offered', function() {
      expect(affordability.borrowing()).toBe(249900);
    });

  });

  describe('#monthlyRepayment', function() {

    it('calculates the monthly repayments of the borrowing', function() {
      calculateRepayments();
      expect(affordability.monthlyRepayment()).toBe(1460.89);
    });

  });

  describe('#takeHomePay', function() {

    it('calculates the total take home pay of the applicant(s)', function() {
      expect(affordability.takeHomePay()).toBe(4742.45);
    });

  });

  describe('#committedCosts', function() {

    it('calculates the total committed costs of the applicant(s)', function() {

      expect(affordability.committedCosts()).toBe(300);
    });

  });

  describe('#fixedCosts', function() {

    it('calculates the total fixed costs of the applicant(s)', function() {
      expect(affordability.fixedCosts()).toBe(925);
    });

  });

  describe('Risk Information', function() {

    describe('#riskPercentage', function() {

      it('calculates the risk percentage of the applicant(s) borrowing', function() {
        calculateRepayments();
        expect(affordability.riskPercentage()).toBe(56);
      });

      it('returns 0 when divided by 0', function() {
        resetApplicantIncome(1);
        resetApplicantIncome(2);
        calculateRepayments();
        expect(affordability.riskPercentage()).toBe(0);
      });

      it('returns 100% when it is over 100%', function() {
        repayments.annualInterestRate = 50;
        calculateRepayments();
        expect(affordability.riskPercentage()).toBe(100);
      });

    });

    describe('#riskLevel', function() {

      it('calculates the risk level of the applicant(s) borrowing based on the risk percentage', function() {
        expect(affordability.riskLevel()).toBe('medium');
      });

    });

  });


  describe('#calculateLifestyleSpend', function() {

    it('calculates the total lifestyle spend of the applicant(s)', function() {
      expect(affordability.calculateLifestyleSpend()).toBe(700);
    });

  });

  describe('#remainingPerMonth', function() {

    it('calculates the remaining spend per month minus all the key costs of the applicant(s)', function() {
      affordability.lifestyleSpend = affordability.calculateLifestyleSpend();
      expect(affordability.remainingPerMonth()).toBe(2817.45);
    });

  });

});
