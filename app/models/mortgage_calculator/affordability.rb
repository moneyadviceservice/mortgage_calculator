module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :people, :outgoings

    validate :validate_people
    validate :validate_outgoings
    validate :income_greater_than_zero

    delegate :committed_costs, to: :outgoings

    currency_inputs :lifestyle_costs

    def people_attributes=(attributes)
    end

    def lifestyle_costs
      @lifestyle_costs || outgoings.lifestyle_costs
    end

    def initialize(people, outgoings, options = {})
      @people = people
      @outgoings = outgoings
      @borrowing = options[:borrowing]
      @interest_rate = options[:interest_rate]
      self.lifestyle_costs = options[:lifestyle_costs]
    end

    def interest_rate
      @interest_rate || 5
    end

    def repayment
      @repayment ||= Repayment.new(price: borrowing, interest_rate: interest_rate)
    end

    def total_income
      @total_income ||= people.sum(&:total_income)
    end

    def number_of_applicants
      people.length
    end

    def to_key
      nil
    end

    def persisted?
      false
    end

    def can_borrow_upto
      (total_income - annual_committed_costs) * upper_profit_multiplier
    end

    def can_borrow_from
      (total_income - annual_committed_costs) * lower_profit_multiplier
    end

    def monthly_net_income
      people.sum(&:monthly_net_income)
    end

    def borrowing
      @borrowing || default_borrowing_amount
    end

    def risk_percentage
      percent = ((committed_costs + repayment.monthly_payment) / monthly_net_income) * 100

      [100, percent].min
    rescue
      0
    end

    def risk_level
      return :low if risk_percentage < 40
      return :high if risk_percentage > 60

      :medium
    end

    def remaining
      monthly_net_income - repayment.monthly_payment - committed_costs - lifestyle_costs
    end

  private

    def lower_profit_multiplier
      2.8
    end

    def upper_profit_multiplier
      4.2
    end

    def annual_committed_costs
      committed_costs * 12
    end

    def income_greater_than_zero
      errors[:base] << I18n.t("affordability.activemodel.errors.mortgage_calculator/affordability.base.income_greater_than_zero") unless total_income + monthly_net_income > 0
    end

    def default_borrowing_amount
      (can_borrow_from + can_borrow_upto) / 2
    end

    def validate_people
      people.each do |person|
        unless person.valid?
          person.errors.full_messages.each do |message|
            errors.add(:base, message)
          end
        end
      end
    end

    def validate_outgoings
      unless outgoings.valid?
        outgoings.errors.full_messages.each do |message|
          errors.add(:base, message)
        end
      end
    end
  end
end
