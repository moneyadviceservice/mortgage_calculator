require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'

module MortgageCalculator
  DAYS_IN_A_MONTH = 30.4368
  DAYS_IN_A_YEAR = 365.242

  mattr_accessor :stamp_duty_enabled
end
