require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'

module MortgageCalculator
  DAYS_IN_A_MONTH = 30.4368
  DAYS_IN_A_YEAR = 365.242

  mattr_accessor :stamp_duty_enabled
  mattr_accessor :stamp_duty_welsh_fix
  mattr_accessor :affordability_enabled

  def self.stamp_duty_welsh_fix
    @@stamp_duty_welsh_fix ||= lambda { |tool, locale| }
  end

  def self.configure
    yield self
  end
end
