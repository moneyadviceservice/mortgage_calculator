module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :people, :outgoings

    attr_accessor :two_applicants

    def two_applicants?
      two_applicants == "1"
    end

    validate :income_greater_than_zero

    delegate :committed_costs, to: :outgoings
    delegate :fixed_costs, to: :outgoings

    currency_inputs :lifestyle_costs

    validates :interest_rate, numericality: true

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
      self.lifestyle_costs = options[:lifestyle_costs] if options[:lifestyle_costs].present?
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
    rescue
      0
    end

    def borrowing
      @borrowing || default_borrowing_amount
    end

    def risk_percentage
      percent = ((committed_costs + fixed_costs + repayment.monthly_payment) / monthly_net_income) * 100

      [100, percent].min
    rescue
      0
    end

    def inverse_risk_percentage
      100 - risk_percentage
    end

    def risk_level
      return :low if risk_percentage < 40
      return :high if risk_percentage > 60

      :medium
    end

    def remaining
      monthly_net_income - repayment.monthly_payment - committed_costs - lifestyle_costs - fixed_costs
    end

    def remaining_positive?
      remaining.sign >= 0
    end

    def remaining_negative?
      !remaining_positive?
    end

    def remaining_vector
      remaining_positive? ? :positive : :negative
    end

    def valid_for_step2?
      valid?
      errors[:base].empty? & !(people.map(&:valid?).include?(false))
    end

    def valid_for_step3?
      valid?
      errors[:base].empty? & outgoings.valid?
    end

    def valid?
      super & outgoings.valid? & !(people.map(&:valid?).include?(false))
    end

    def budget_outgoing
      repayment.monthly_payment + fixed_costs + committed_costs
    end

    def budget_leftover
      monthly_net_income - budget_outgoing
    end

    def missing_lifestyle_costs_warning?
      lifestyle_costs.zero?
    end

    def missing_fixed_and_committed_costs_warning?
      fixed_costs.zero? && committed_costs.zero?
    end

    def only_rent_and_mortgage_warning?
      outgoings.fixed_costs.zero? && !outgoings.rent_and_mortgage.zero?
    end

    def save(store)
      store[:affordability] = {
        "people_attributes" => people_hash,
        "two_applicants" => two_applicants,
        "outgoings" => outgoings.serializable_hash
      }
    end

    def self.load_from_store(store)
      store = ActiveSupport::HashWithIndifferentAccess.new(store)[:affordability]

      people = store[:people_attributes].values.map do |p|
        PersonPresenter.new(Person.new(p))
      end

      people << PersonPresenter.new(Person.new) if people.size == 1

      outgoings = OutgoingsPresenter.new(Outgoings.new(store[:outgoings]))
      borrowing = store[:borrowing]
      interest_rate = store[:interest_interest]
      lifestyle_costs = store[:lifestyle_costs]
      options = { borrowing: borrowing, interest_rate: interest_rate, lifestyle_costs: lifestyle_costs }

      new(people, outgoings, options = {})
    end

  private

    def people_hash
      array = people.each_with_index.map do |person, i|
        person = PersonPresenter.new(person)
        {i.to_s => person.serializable_hash}
      end

      Hash[*array.map{|e| e.keys.zip e.values}.flatten]
    end

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
  end
end
