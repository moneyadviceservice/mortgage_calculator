'use strict';

App.factory('Affordability', ['Repayments', function(Repayments) {
    var DEFAULT_INTEREST_RATE_CHANGE_AMOUNT = 3;

    var affordability = {
      earnings: {
        person0 : {
          annual: 0,
          extra: 0,
          net_pay: 0
        },
        person1 : {
          annual: 0,
          extra: 0,
          net_pay: 0
        }
      },
      outgoings: {
        credit_repayments: 0,
        child_maintenance: 0,
        childcare: 0,
        travel: 0,
        utilities: 0,
        rent_and_mortgage: 0,
        entertainment: 0,
        holidays: 0,
        food: 0
      },
      numberOfPeople: [0, 1],

      lifestyleSpend: 0,

      minimumBorrowing: function() {
        return Math.round(( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 2.8);
      },

      maximumBorrowing: function() {
        return Math.round(( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 4.2);
      },

      borrowing: function() {
        return (this.minimumBorrowing() + this.maximumBorrowing()) / 2;
      },

      monthlyRepayment: function(increment) {
        return Repayments.monthlyRepayment(increment);
      },

      monthlyRepaymentAfterDefaultInterestRateChange : function() {
        return this.monthlyRepayment(DEFAULT_INTEREST_RATE_CHANGE_AMOUNT);
      },

      rentAndMortgage: function() {
        return this.outgoings.rent_and_mortgage;
      },

      takeHomePay: function() {
        return this.earnings.person0.net_pay + this.earnings.person1.net_pay;
      },

      committedCosts: function() {
        return this.outgoings.credit_repayments + this.outgoings.child_maintenance;
      },

      fixedCosts: function() {
        return this.outgoings.childcare + this.outgoings.travel + this.outgoings.utilities;
      },

      riskPercentage: function(increment) {
        var result = Math.round(( (this.monthlyRepayment(increment) + this.committedCosts() + this.fixedCosts()) / this.takeHomePay() ) * 100),
            percentage = _.min([100, result]);

        if (isFinite(result)) {
          return percentage;
        } else {
          return 0;
        }
      },

      percentageAfterRisk: function() {
        return 100 - this.riskPercentage();
      },

      riskLevel: function() {
        if (this.riskPercentage() < 40) return 'low';
        if (this.riskPercentage() > 60) return 'high';
        return 'medium';
      },

      riskAmount: function(increment) {
        return Math.round((this.monthlyRepayment(increment) + this.committedCosts() + this.fixedCosts()) * 100 ) / 100;
      },

      amountAfterRisk: function() {
        return Math.round((this.takeHomePay() - this.riskAmount()) * 100 ) / 100;
      },

      calculateLifestyleSpend: function() {
        return this.outgoings.entertainment + this.outgoings.holidays + this.outgoings.food;
      },

      getLifestyleSpend: function() {
        return this.lifestyleSpend || 0;
      },

      remainingPerMonth: function(increment) {
        return Math.round(((this.takeHomePay() - this.riskAmount(increment)) - this.getLifestyleSpend()) * 100 ) / 100;
      },

      remainingPerMonthAfterDefaultInterestRateChange: function() {
        return this.remainingPerMonth(DEFAULT_INTEREST_RATE_CHANGE_AMOUNT);
      },

      remainingVector: function() {
        return this.remainingPerMonth() >= 0 ? 'positive' : 'negative';
      }
    };

    /**
     * @private
     */

    var _totalIncome = function(earnings) {
      var sum = _.reduce(earnings, function(memo, person){
        var annual = person.annual || 0,
            extra  = person.extra  || 0;
        return memo + annual + extra;
      }, 0);
      return sum;
    };


    return affordability;
  }]);
