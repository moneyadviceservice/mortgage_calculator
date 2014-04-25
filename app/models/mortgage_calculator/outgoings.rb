module MortgageCalculator
  class Outgoings
    include CurrencyInput::Macro

    attr_accessor :credit_repayments, :utilities, :childcare,
                  :child_maintenance, :rent_and_mortgage,
                  :food, :travel, :entertainment

    currency_inputs :credit_repayments, :utilities, :childcare,
                    :child_maintenance, :rent_and_mortgage,
                    :food, :travel, :entertainment

    def initialize(attributes = {})
      # Sorry. Rails 3.2 Doesn't have ActiveModel::Model

      self.credit_repayments = attributes[:credit_repayments] || 0
      self.utilities = attributes[:utilities] || 0
      self.childcare = attributes[:childcare] || 0
      self.child_maintenance = attributes[:child_maintenance] || 0
      self.rent_and_mortgage = attributes[:rent_and_mortgage] || 0
      self.food = attributes[:food] || 0
      self.travel = attributes[:travel] || 0
      self.entertainment = attributes[:entertainment] || 0
    end

    def committed_costs
      credit_repayments + utilities + childcare + child_maintenance
    end
  end
end
