'use strict';

App.factory('Affordability', ['Repayments', function(Repayments) {

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
      numberOfPeople        : [0, 1],

      lifestyleSpend: 0,

      minimumBorrowing: function() {
        return ( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 2.8;
      },

      maximumBorrowing: function() {
        return ( _totalIncome(this.earnings) - (this.committedCosts() * 12) )  * 4.2;
      },

      borrowing: function() {
        return (this.minimumBorrowing() + this.maximumBorrowing()) / 2;
      },

      monthlyRepayment: function(increment) {
        return Repayments.monthlyRepayment(increment);
      },

      takeHomePay: function() {
        return this.earnings.person0.net_pay + this.earnings.person1.net_pay;
      },

      committedCosts: function() {
        return this.outgoings.credit_repayments + this.outgoings.child_maintenance;
      },

      calculateLifestyleSpend: function() {
        return this.outgoings.entertainment + this.outgoings.holidays + this.outgoings.food;
      },

      fixedCosts: function() {
        return this.outgoings.childcare + this.outgoings.travel + this.outgoings.utilities;
      },

      remainingPerMonth: function(increment) {
        return this.takeHomePay() - this.monthlyRepayment(increment) - (this.committedCosts() + this.fixedCosts()) - this.lifestyleSpend;
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

    var _sumOf = function(costs) {
      var sum = _.reduce(costs, function(memo, cost){
        cost = cost || 0;
        return memo + cost;
      }, 0);
      return sum;
    };


    return affordability;
  }]);
