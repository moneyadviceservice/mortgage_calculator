module MortgageCalculator
  class PersonPresenter
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :persisted?, to: :model

    def initialize(model)
      @model = model
    end

    def annual_income
      number_to_currency model.annual_income, unit: nil
    end

    def extra_income
      number_to_currency model.extra_income, unit: nil
    end
  end
end
