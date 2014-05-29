module MortgageCalculator
  class AffordabilityPresenter
    extend ActiveModel::Translation
    extend ActiveModel::Naming
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :people, :persisted?, to: :model
    delegate :monthly_debt, to: :model
    delegate :people_attributes=, to: :model
    delegate :outgoings, to: :model
    delegate :repayment, to: :model
    delegate :valid?, to: :model
    delegate :monthly_net_income, to: :model
    delegate :can_borrow_from, to: :model
    delegate :can_borrow_upto, to: :model
    delegate :interest_rate, to: :model
    delegate :committed_costs, to: :model
    delegate :fixed_costs, to: :model
    delegate :risk_percentage, to: :model
    delegate :inverse_risk_percentage, to: :model
    delegate :risk_level, to: :model
    delegate :remaining, to: :model
    delegate :errors, to: :model

    delegate :budget_outgoing, to: :model
    delegate :budget_leftover, to: :model

    def self.i18n_scope
      "affordability.activemodel"
    end

    def initialize(model)
      @model = model
    end

    def to_key
      nil
    end

    def borrowing
      number_to_currency model.borrowing, precision: 0, unit: ""
    end

    def lifestyle_costs
      number_to_currency model.lifestyle_costs, precision: 0, unit: ""
    end

    def monthly_debt
      number_to_currency model.monthly_debt, unit: nil
    end

    def budget_outgoing_formatted
      number_to_currency model.budget_outgoing
    end

    def budget_leftover_formatted
      number_to_currency model.budget_leftover
    end

    def self.model_name
      ActiveModel::Name.new(Affordability, MortgageCalculator)
    end
  end
end
