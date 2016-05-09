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
      resetApplicantIncome(1);
      expect(affordability.minimumBorrowing()).toBe(101920);
    });

    it('calculates the minimum amount two applicants can borrow', function() {
      expect(affordability.minimumBorrowing()).toBe(199920);
    });
  });

  describe('#maximumBorrowing', function() {

    it('calculates the maximum amount a single applicant can borrow', function() {
      resetApplicantIncome(1);
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
      expect(affordability.monthlyRepayment()).toBe(1185.05);
    });

  });

  describe('#currentRepayment', function() {

    it('returns the current outgoing rent and mortgage payments', function() {
      expect(affordability.rentAndMortgage()).toBe(900);
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


  describe('#riskPercentage', function() {

    it('calculates the risk percentage of the applicant(s) borrowing', function() {
      calculateRepayments();
      expect(affordability.riskPercentage()).toBe(51);
    });

    it('returns 0 when divided by 0', function() {
      resetApplicantIncome(0);
      resetApplicantIncome(1);
      calculateRepayments();
      expect(affordability.riskPercentage()).toBe(0);
    });

    it('returns 100% when it is over 100%', function() {
      repayments.annualInterestRate = 50;
      calculateRepayments();
      expect(affordability.riskPercentage()).toBe(100);
    });

  });

  describe('#percentageAfterRisk', function() {

    it('returns the remaining percentage after the risk percentage', function() {
      calculateRepayments();
      expect(affordability.percentageAfterRisk()).toBe(49);
    });

  });


  describe('#riskLevel', function() {


    it('returns low when risk is under 40%', function() {
      affordability.outgoings.credit_repayments = 0;
      affordability.outgoings.travel = 0;
      calculateRepayments();
      expect(affordability.riskLevel()).toBe('low');
    });

    it('returns medium when risk is between 40% - 60%', function() {
      calculateRepayments();
      expect(affordability.riskLevel()).toBe('medium');
    });

    it('returns high when risk is over 60%', function() {
      repayments.annualInterestRate = 10;
      calculateRepayments();
      expect(affordability.riskLevel()).toBe('high');
    });

  });

  describe('#riskAmount', function() {

    it('returns an amount of the take home pay taken by the risk percentage', function() {
      calculateRepayments();
      expect(affordability.riskAmount()).toBe(2410.05);
    });

  });

  describe('#amountAfterRisk', function() {

    it('returns the remaining percentage after the risk percentage', function() {
      calculateRepayments();
      expect(affordability.amountAfterRisk()).toBe(2332.4);
    });

  });


  describe('#calculateLifestyleSpend', function() {

    it('calculates the total lifestyle spend of the applicant(s)', function() {
      expect(affordability.calculateLifestyleSpend()).toBe(700);
    });

  });

  describe('#getLifestyleSpend', function() {

    it('returns the lifestyleSpend', function() {
      affordability.lifestyleSpend = 1234.56;

      expect(affordability.getLifestyleSpend()).toBe(1234.56);
    });

    it('returns 0 if lifestyleSpend is null', function() {
      affordability.lifestyleSpend = null;

      expect(affordability.getLifestyleSpend()).toBe(0);
    });

    it('returns 0 if lifestyleSpend is empty string', function() {
      affordability.lifestyleSpend = '';

      expect(affordability.getLifestyleSpend()).toBe(0);
    });

  });

  describe('#remainingPerMonth', function() {

    it('calculates the remaining spend per month minus all the key costs of the applicant(s)', function() {
      calculateRepayments();
      affordability.lifestyleSpend = affordability.calculateLifestyleSpend();
      expect(affordability.remainingPerMonth()).toBe(1632.40);
    });

    it('calculates the remaining spend per month, even when lifestyleSpend is null', function() {
      calculateRepayments();
      affordability.lifestyleSpend = null;
      expect(affordability.remainingPerMonth()).toBe(2332.40);
    });

  });

  describe('#remainingBuffer', function() {

    it('calculates the applicant(s) remaining buffer after a 2% increase', function() {
      repayments.annualInterestRate = 7;
      calculateRepayments();
      affordability.lifestyleSpend = affordability.calculateLifestyleSpend();
      expect(affordability.remainingPerMonth()).toBe(1051.21);
    });

    it('calculates the applicant(s) remaining buffer after a 2% increase, even when lifestyleSpend is null', function() {
      repayments.annualInterestRate = 7;
      calculateRepayments();
      affordability.lifestyleSpend = null;
      expect(affordability.remainingPerMonth()).toBe(1751.21);
    });

  });

});
