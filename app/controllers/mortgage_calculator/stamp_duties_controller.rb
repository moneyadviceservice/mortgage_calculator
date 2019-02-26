module MortgageCalculator
  class StampDutiesController < ::MortgageCalculator::PropertyTaxCalculatorController
    def calculator
      MortgageCalculator::StampDuty
    end

    def i18n_locale_namespace
      'stamp_duty'
    end
    helper_method :i18n_locale_namespace

    def calculator_form_path
      stamp_duty_path
    end
    helper_method :calculator_form_path

    def other_countries
      ['scotland', 'wales']
    end
    helper_method :other_countries
  end
end
