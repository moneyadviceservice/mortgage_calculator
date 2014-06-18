module MortgageCalculator
  class PersonPresenter
    include ActionView::Helpers::NumberHelper
    include ActiveModel::Serialization

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
    delegate :empty?, to: :model

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

    def attributes
      HashWithIndifferentAccess.new({
        'annual_income' => annual_income.to_s,
        'extra_income' => extra_income.to_s,
        'monthly_net_income' => monthly_net_income.to_s
      })
    end

    private

    def read_attribute_for_serialization(key)
      attributes[key]
    end
  end
end
