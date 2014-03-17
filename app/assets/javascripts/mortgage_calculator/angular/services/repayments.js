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

    monthlyRepayment        : function() {
      return Math.round((_debt() * _monthlyInterestRate() * _compoundInterest()) / (_compoundInterest() - 1) * 100) / 100;
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

  var _monthlyInterestRate = function() {

    var args = Args([
      {interestRate:  Args.INT | Args.Optional,
        _default: 0}
    ], arguments);

    return ((repayments.annualInterestRate + args.interestRate) / 12 / 100);
  };

  var _annualInterestRate = function(num) {

    var args = Args([
      {interestRate:  Args.INT | Args.Optional,
        _default: 0}
    ], arguments);

    return ((repayments.annualInterestRate + args.interestRate) / 100);
  };

  var _compoundInterest = function() {
    return Math.pow(1 + _monthlyInterestRate(), _termMonths());
  };



  return repayments;

});
