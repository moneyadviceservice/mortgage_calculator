module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper
    extend ActiveModel::Naming

    def self.i18n_scope
      "affordability.activemodel"
    end

    attr_accessor :annual_income, :extra_income, :monthly_net_income, :allow_blanks, :affordability

    validates :extra_income, numericality: true, unless: :allow_blanks?

    validates :annual_income, numericality: true, unless: :allow_blanks?
    validates :annual_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:annual_income).downcase) } }, unless: :allow_blanks?

    validates :monthly_net_income, numericality: true, unless: :allow_blanks?
    validates :monthly_net_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:monthly_net_income).downcase) } }, unless: :allow_blanks?

    currency_inputs :annual_income, :extra_income, :monthly_net_income

    validate :validate_proportional_incomes

    def initialize(options = {}, param_allow_blanks = false)
      self.annual_income = options[:annual_income].presence
      self.extra_income = options[:extra_income].presence || 0
      self.monthly_net_income = options[:monthly_net_income].presence
      self.allow_blanks = param_allow_blanks
    end

    def persisted?
      false
    end

    def total_income
      safe_annual_income + safe_extra_income
    end

    def annual_income_formatted
      number_to_currency annual_income, unit: ""
    end

    def extra_income_formatted
      number_to_currency extra_income, unit: ""
    end

    def monthly_net_income_formatted
      number_to_currency monthly_net_income, unit: ""
    end

    def allow_blanks?
      return false if affordability.try(:two_applicants?)
      return self.allow_blanks
    end

    private

    def validate_proportional_incomes
      if total_income < (monthly_net_income || 0) * 12
        if index_in_affordability == 0
          errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.proportional_incomes")
        else
          errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/person_other.base.proportional_incomes")
        end
      end
    end

    def index_in_affordability
      affordability.try(:people).try(:index, self)
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
