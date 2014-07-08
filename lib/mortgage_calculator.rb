require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'
require 'mortgage_calculator/localize_route'

module MortgageCalculator
  mattr_accessor :affordability_enabled

  def self.configure
    yield self
  end
end
