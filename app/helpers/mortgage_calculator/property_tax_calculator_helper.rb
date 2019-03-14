module MortgageCalculator
  module PropertyTaxCalculatorHelper
    def stamp_duty_calculator?
      resource.class.name == 'MortgageCalculator::StampDuty'
    end
  end
end
