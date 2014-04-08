module MortgageCalculator
  class StampDutyPresenter < CalculatorPresenter

    convert_to_currency :price, :tax_due, :total_due

    delegate :percentage_rate, to: :model

    def self.model_name
      StampDuty.model_name
    end
  end
end
