module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro

    attr_accessor :annual_income, :extra_income, :monthly_net_income

    validates :annual_income, numericality: true
    validates :extra_income, numericality: true
    validates :monthly_net_income, numericality: true
    validate :validate_associated_incomes
    validate :validate_proportional_incomes

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
    rescue
      0
    end

    def can_borrow_upto
      total_income * upper_profit_multiplier
    end

    def can_borrow_from
      total_income * lower_profit_multiplier
    end

    private

    def validate_proportional_incomes
      if total_income < (monthly_net_income || 0) * 12
        errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.proportional_incomes")
      end
    end

    def validate_associated_incomes
      return unless total_income && monthly_net_income

      if !total_income.zero? && monthly_net_income.zero?
        errors[:base] << "Take home pay should be more than zero if annual income is more than zero"
      end

      if total_income.zero? && !monthly_net_income.zero?
        errors[:base] << "Annual income should be more than zero if take home pay is more than zero"
      end
    end

    def lower_profit_multiplier
      2.8
    end

    def upper_profit_multiplier
      4.2
    end
  end
end
