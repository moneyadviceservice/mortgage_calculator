'use strict';

App.factory('Repayments', function() {


  var repayments = {
    propertyPrice           : 0,
    deposit                 : 0,
    termYears               : 25,
    annualInterestRate      : 5,

    mortgage                : function() {
      return _debt();
    },

    monthlyRepayment        : function(increment) {
      var result = Math.round((_debt() * _monthlyInterestRate(increment) * _compoundInterest(increment)) / (_compoundInterest(increment) - 1) * 100) / 100;
      return _normalizedResults(result);
    },
    monthlyInterestRepayment : function(increment) {
      var result = Math.round(((_debt() * _annualInterestRate(increment)) / 12) * 100 ) / 100;
      return _normalizedResults(result);
    }
  };

  var _debt = function() {
    return (repayments.propertyPrice || 0) - (repayments.deposit || 0);
  };

  var _termMonths = function() {
    return repayments.termYears * 12;
  };

  var _monthlyInterestRate = function(increment) {
    return ((repayments.annualInterestRate + _incrementBy(increment).interestRate) / 12 / 100);
  };

  var _annualInterestRate = function(increment) {
    return ((repayments.annualInterestRate + _incrementBy(increment).interestRate) / 100);
  };

  var _compoundInterest = function(increment) {
    return Math.pow(1 + _monthlyInterestRate(increment), _termMonths());
  };

  var _incrementBy = function() {
    var args = Args([
      {interestRate:  Args.INT | Args.Optional,
        _default: 0}
    ], arguments);
    return args;
  };

  var _normalizedResults = function(result) {
    return Math.max(0, result) || 0;
  };


  return repayments;

});
