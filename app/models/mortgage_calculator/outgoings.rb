module MortgageCalculator
  class Outgoings
    attr_accessor :credit_repayments, :utilities, :childcare,
                  :child_maintenance, :rent_and_mortgage,
                  :food, :travel, :entertainment

    def initialize(attributes)
      # Sorry. Rails 3.2 Doesn't have ActiveModel::Model

      self.credit_repayments = attributes[:credit_repayments]
      self.utilities = attributes[:utilities]
      self.childcare = attributes[:childcare]
      self.child_maintenance = attributes[:child_maintenance]
      self.rent_and_mortgage = attributes[:rent_and_mortgage]
      self.food = attributes[:food]
      self.travel = attributes[:travel]
      self.entertainment = attributes[:entertainment]
    end

    def committed_costs
      credit_repayments + utilities + childcare + child_maintenance
    end
  end
end
