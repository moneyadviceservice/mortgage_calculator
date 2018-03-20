module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::TransactionTaxCalculatorController
    def calculator
      MortgageCalculator::LandAndBuildingsTransactionTax
    end
  end
end
