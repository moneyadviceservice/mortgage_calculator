module MortgageCalculator
  module PropertyTaxCalculatorHelper
    include PhaseHelper

    def stamp_duty_calculator?
      resource.class.name == 'MortgageCalculator::StampDuty'
    end

    def additional_property_rate
      resource.class::SECOND_HOME_ADDITIONAL_TAX
    end
  end
end
