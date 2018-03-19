module MortgageCalculator
  class LandTransactionTaxesController < ::MortgageCalculator::TransactionTaxCalculatorController
    def calculator
      MortgageCalculator::LandTransactionTax
    end
  end
end
