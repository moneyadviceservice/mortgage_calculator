require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'

module MortgageCalculator
  mattr_accessor :affordability_enabled

  def self.configure
    yield self
  end
end
