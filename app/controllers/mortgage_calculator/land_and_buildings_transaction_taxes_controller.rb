module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::PropertyTaxCalculatorController
    def calculator
      MortgageCalculator::LandAndBuildingsTransactionTax
    end

    def i18n_locale_namespace
      'land_and_buildings_transaction_tax'
    end
    helper_method :i18n_locale_namespace

    def calculator_form_path
      land_and_buildings_transaction_tax_path
    end
    helper_method :calculator_form_path

    def other_countries
      ['england_ni', 'wales']
    end
    helper_method :other_countries
  end
end
