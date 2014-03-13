'use strict';

App.factory('Repayments', function() {


  var repayments = {
    propertyPrice           : 0,
    deposit                 : 0,
    termYears               : 25,
    annualInterestRate      : 5,

    monthlyRepayment        : function() {
      return Math.round((_debt() * _monthlyInterestRate() * _compoundInterest()) / (_compoundInterest() - 1) * 100) / 100;
    },
    monthlyInterestRepayment : function() {
      return Math.round(((_debt() * _annualInterestRate()) / 12) * 100 ) / 100;
    }
  };

  var _debt = function() {
    return repayments.propertyPrice - repayments.deposit;
  };

  var _termMonths = function() {
    return repayments.termYears * 12;
  };

  var _monthlyInterestRate = function() {
    return (repayments.annualInterestRate / 12 / 100);
  };

  var _annualInterestRate = function() {
    return (repayments.annualInterestRate / 100);
  };

  var _compoundInterest = function() {
    return Math.pow(1 + _monthlyInterestRate(), _termMonths());
  };



  return repayments;

});
