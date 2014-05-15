'use strict';

App.factory('Affordability', ['Repayments', function(Repayments) {

    var repayments = Repayments;

    var affordability = {
      earnings: {
        person1 : {
          annual: 0,
          extra: 0,
          net_pay: 0
        },
        person2 : {
          annual: 0,
          extra: 0,
          net_pay: 0
        }
      },
      outgoings: {
        committed: {
          credit_repayments: 0,
          childcare: 0
        },
        fixed: {
          child_maintenance: 0,
          travel: 0,
          utilities: 0,
          rent_and_mortgage: 0
        },
        lifestyle: {
          entertainment: 0,
          holidays: 0,
          food: 0
        }
      },
      numberOfPeople        : [1, 2],

      annualInterestRate: repayments.annualInterestRate,

      monthlyRepayment: function() {
        repayments.propertyPrice = this.borrowing();
        return repayments.monthlyRepayment();
      },

      takeHomePay: function() {
        return this.earnings.person1.net_pay + this.earnings.person2.net_pay;
      },

      committedCosts: function() {
        return _sumOf(this.outgoings.committed);
      },

      minimumBorrowing: function() {
        return ( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 2.8;
      },

      maximumBorrowing: function() {
        return ( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 4.2;
      },

      borrowing: function() {
        return (this.minimumBorrowing() + this.maximumBorrowing()) / 2;
      }
    };

    /**
     * _private
     */

    var _totalIncome = function(earnings) {
      var sum = _.reduce(earnings, function(memo, person){
        var annual = person.annual || 0,
            extra  = person.extra  || 0;
        return memo + annual + extra;
      }, 0);
      return sum;
    };

    var _sumOf = function(costs) {
      var sum = _.reduce(costs, function(memo, cost){
        return memo + cost;
      }, 0);
      return sum;
    };


    return affordability;
  }]);
