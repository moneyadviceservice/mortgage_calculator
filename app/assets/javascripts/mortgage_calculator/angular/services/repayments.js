'use strict';

App.factory('Repayments', function() {
  var DEFAULT_ANNUAL_INTEREST_RATE = 3
    , INTEREST_RATE_STEP           = 0.25
    , MIN_ANNUAL_INTEREST_RATE     = 1
    , MAX_ANNUAL_INTEREST_RATE     = 15
    , DEFAULT_ANNUAL_TERM_YEARS    = 25
    , TERM_YEARS_STEP              = 1
    , MIN_ANNUAL_TERM_YEARS        = 5
    , MAX_ANNUAL_TERM_YEARS        = 40;

  var repayments = {
    propertyPrice           : 0,
    deposit                 : 0,
    termYears               : DEFAULT_ANNUAL_TERM_YEARS,
    termYearsStep           : TERM_YEARS_STEP,
    maxTermYears            : MAX_ANNUAL_TERM_YEARS,
    minTermYears            : MIN_ANNUAL_TERM_YEARS,
    annualInterestRate      : DEFAULT_ANNUAL_INTEREST_RATE,
    interestRateStep        : INTEREST_RATE_STEP,
    maxInterestRate         : MAX_ANNUAL_INTEREST_RATE,
    minInterestRate         : MIN_ANNUAL_INTEREST_RATE,

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
