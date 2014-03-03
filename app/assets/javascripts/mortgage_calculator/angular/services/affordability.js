'use strict';

angular.module('mortgageCalculatorApp')
  .factory('Affordability', function() {

    var affordability = {
      earnings: {
        person1 : {
          annual: 0,
          extra: 0
        },
        person2 : {
          annual: 0,
          extra: 0
        }
      },
      numberOfPeople        : [1, 2],
      personalSpend         : null,

      /**
       * Calculates applicant(s) total income
       * @return {integer} Returns total income of applicant(s)
       */
      totalIncome: function() {
        return _convertToNumbers(this.earnings);
      },

      /**
       * Calculates minimum borrowing applicant(s) can have with a multiplier of 3
       * @return {integer} Returns minimum borrowing available
       */
      minimumBorrowing: function() {
        return this.totalIncome() * 3;
      },

      /**
       * Calculates the maximum borrowing applicant(s) can have with a multiplier of 4
       * @return {integer} Returns maximum borrowing available
       */
      maximumBorrowing: function() {
        return this.totalIncome() * 4;
      }
    };

    /**
     * _private
     * Converts user string inputs (annual and extra income) into integers so calculations can be done correctly
     * @param  {object} earnings An object containing data on the applicant(s) supplied income
     * @return {integer}         Returns total sum of applicant(s) supplied income
     */
    var _convertToNumbers = function(earnings) {
      var sum = _.reduce(earnings, function(memo, person){
        var annual = person.annual || 0,
            extra  = person.extra  || 0;
        return memo + (parseInt(annual) + parseInt(extra));
      }, 0);
      return sum;
    };

    return affordability;
  });
