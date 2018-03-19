module MortgageCalculator
  class LandTransactionTaxesController < ::MortgageCalculator::TransactionTaxCalculatorController
    def calculator
      MortgageCalculator::LandTransactionTax
    end

    def i18n_locale_namespace
      'land_transaction_tax'
    end
    helper_method :i18n_locale_namespace

    def calculator_form_path
      land_transaction_tax_path
    end
    helper_method :calculator_form_path
  end
end
