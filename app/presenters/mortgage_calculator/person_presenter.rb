module MortgageCalculator
  class PersonPresenter
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :persisted?, to: :model
    delegate :can_borrow_from, to: :model
    delegate :can_borrow_upto, to: :model
    delegate :annual_income, to: :model
    delegate :extra_income, to: :model
    delegate :monthly_net_income, to: :model
    delegate :total_income, to: :model
    delegate :valid?, to: :model
    delegate :errors, to: :model

    def initialize(model)
      @model = model
    end

    def annual_income_formatted
      number_to_currency model.annual_income, unit: nil
    end

    def extra_income_formatted
      number_to_currency model.extra_income, unit: nil
    end

    def monthly_net_income_formatted
      number_to_currency model.monthly_net_income, unit: nil
    end

    def self.model_name
      ActiveModel::Name.new(Person, MortgageCalculator)
    end
  end
end
