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
      return Math.round((_debt() * _monthlyInterestRate(increment) * _compoundInterest(increment)) / (_compoundInterest(increment) - 1) * 100) / 100;
    },
    monthlyInterestRepayment : function(increment) {
      return Math.round(((_debt() * _annualInterestRate(increment)) / 12) * 100 ) / 100;
    }
  };

  var _debt = function() {
    return repayments.propertyPrice - repayments.deposit;
  };

  var _termMonths = function() {
    return repayments.termYears * 12;
  };

  var _monthlyInterestRate = function(increment) {

    //If interest rate increment is supplied, adds it otherwise uses default annualInterestRate property.
    var args = Args([
      {interestRate:  Args.INT | Args.Optional,
        _default: 0}
    ], arguments);
    return ((repayments.annualInterestRate + args.interestRate) / 12 / 100);
  };

  var _annualInterestRate = function(increment) {

    var args = Args([
      {interestRate:  Args.INT | Args.Optional,
        _default: 0}
    ], arguments);
    return ((repayments.annualInterestRate + args.interestRate) / 100);
  };

  var _compoundInterest = function(increment) {
    return Math.pow(1 + _monthlyInterestRate(increment), _termMonths());
  };



  return repayments;

});
