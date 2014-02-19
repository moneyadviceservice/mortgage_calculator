'use strict';

angular.module('mortgageCalculatorApp')
  .factory('Affordability', function() {

    var affordability = {

      earnings: {

        personOne : {
          annual: 0,
          extra: 0
        },
        personTwo : {
          annual: 0,
          extra: 0
        }

      },
      numberOfPeople        : [1, 2],
      personalSpend         : null,

      totalIncome: function() {
        return convertToNumbers(this.earnings);
      },

      minimumBorrowing: function() {
        return this.totalIncome() * 3;
      },

      maximumBorrowing: function() {
        return this.totalIncome() * 4;
      }
    };

    //Private

    var convertToNumbers = function(earnings) {

      var sum = _.reduce(earnings, function(memo, person){
        var annual = person.annual || 0,
            extra  = person.extra  || 0;
        return memo + (parseInt(annual) + parseInt(extra));
      }, 0);

      return sum;

    };



    return affordability;


  });
