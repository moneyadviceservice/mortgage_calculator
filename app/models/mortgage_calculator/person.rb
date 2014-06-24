module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper

    def self.i18n_scope
      "affordability.activemodel"
    end

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
      safe_annual_income + safe_extra_income
    end

    def annual_income_formatted
      number_to_currency annual_income, unit: nil
    end

    def extra_income_formatted
      number_to_currency extra_income, unit: nil
    end

    def monthly_net_income_formatted
      number_to_currency monthly_net_income, unit: nil
    end

    private

    def validate_proportional_incomes
      return unless valid_number?(annual_income)

      if total_income < (monthly_net_income || 0) * 12
        errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.proportional_incomes")
      end
    end

    def validate_associated_incomes
      return unless total_income && monthly_net_income

      if !total_income.zero? && monthly_net_income.zero?
        errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.take_home_is_zero")
      end

      if total_income.zero? && !monthly_net_income.zero?
        errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.annual_income_is_zero")
      end
    end

  protected

    def safe_annual_income
      BigDecimal.new(annual_income)
    rescue
      0
    end

    def safe_extra_income
      BigDecimal.new(extra_income)
    rescue
      0
    end

    def valid_number?(number)
      n = Float(number)

      true
    rescue
      false
    end

  end
end
