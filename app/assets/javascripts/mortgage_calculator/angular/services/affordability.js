'use strict';

angular.module('mortgageCalculatorApp')
  .service('Affordability', function() {

    this.annualIncome           = null;
    this.extraIncome            = null;
    this.personTwoAnnualIncome  = null;
    this.personTwoExtraIncome   = null;
    this.numberOfPeople         = [1, 2];
    this.personalSpend          = null;


    //Calculate Income and Total Mortgage

    this.totalIncome = function() {
      return convertToNumbers(this.annualIncome, this.extraIncome, this.personTwoAnnualIncome, this.personTwoExtraIncome);
    };

    this.minimumBorrowing = function() {
      return this.totalIncome() * 3;
    };

    this.maximumBorrowing = function() {
      return this.totalIncome() * 4;

    };

    //Private

    var convertToNumbers = function(income, extraIncome, secondIncome, secondExtraIncome) {
      income = income || 0;
      extraIncome = extraIncome || 0;
      secondIncome = secondIncome || 0;
      secondExtraIncome = secondExtraIncome || 0;

      return (parseInt(income) + parseInt(extraIncome) + parseInt(secondIncome) + parseInt(secondExtraIncome));
    };


  });
