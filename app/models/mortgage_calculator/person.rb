module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro

    attr_accessor :annual_income, :extra_income, :monthly_net_income

    validates :annual_income, numericality: true

    currency_inputs :annual_income, :extra_income, :monthly_net_income

    def initialize(options = {})
      annual_income = options[:annual_income].presence || 0
      extra_income = options[:extra_income].presence || 0
      monthly_net_income = options[:monthly_net_income].presence || 0

      self.annual_income = annual_income
      self.extra_income = extra_income
      self.monthly_net_income = monthly_net_income
    end

    def persisted?
      false
    end

    def total_income
      annual_income + extra_income
    end
  end
end
