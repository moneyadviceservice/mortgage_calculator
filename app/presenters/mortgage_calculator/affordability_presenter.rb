module MortgageCalculator
  class AffordabilityPresenter
    extend ActiveModel::Naming
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :people, :persisted?, to: :model
    delegate :monthly_debt, to: :model
    delegate :people_attributes=, to: :model

    def initialize(model)
      @model = model
    end

    def to_key
      nil
    end

    def monthly_debt
      number_to_currency model.monthly_debt, unit: nil
    end

    def self.model_name
      ActiveModel::Name.new(Affordability, MortgageCalculator)
    end
  end
end
