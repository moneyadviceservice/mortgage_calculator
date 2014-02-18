module MortgageCalculator
  class StampDutyPresenter
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :persisted?, :valid?, :errors, to: :model

    def initialize(model)
      @model = model
    end

    def price
      number_to_currency model.price, unit: nil
    end

    def percentage_rate
      model.percentage_rate
    end

    def tax_due
      number_to_currency model.tax_due, unit: nil
    end

    def total_due
      number_to_currency model.total_due, unit: nil
    end

    def self.model_name
      StampDuty.model_name
    end

    def to_key
      nil
    end
  end
end
