'use strict';

angular.module('mortgageCalculatorApp')
  .factory('Affordability', function() {

    var affordability = {

      annualIncome          : null,
      extraIncome           : null,
      personTwoAnnualIncome : null,
      personTwoExtraIncome  : null,
      numberOfPeople        : [1, 2],
      personalSpend         : null,

      totalIncome: function() {
        return convertToNumbers(this.annualIncome, this.extraIncome, this.personTwoAnnualIncome, this.personTwoExtraIncome);
      },

      minimumBorrowing: function() {
        return this.totalIncome() * 3;
      },

      maximumBorrowing: function() {
        return this.totalIncome() * 4;
      }
    };



    //Calculate Income and Total Mortgage

    //Private

    var convertToNumbers = function(income, extraIncome, secondIncome, secondExtraIncome) {
      income = income || 0;
      extraIncome = extraIncome || 0;
      secondIncome = secondIncome || 0;
      secondExtraIncome = secondExtraIncome || 0;
      return (parseInt(income) + parseInt(extraIncome) + parseInt(secondIncome) + parseInt(secondExtraIncome));
    };

    return affordability;


  });
