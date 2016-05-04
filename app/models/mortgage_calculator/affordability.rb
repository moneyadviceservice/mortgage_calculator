module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    extend ActiveModel::Translation
    include ActionView::Helpers::NumberHelper

    def self.i18n_scope
      "affordability.activemodel"
    end

    attr_reader :people, :outgoings

    attr_accessor :two_applicants, :empty, :term_years

    def two_applicants?
      two_applicants == "1"
    end

    def empty?
      empty
    end

    delegate :committed_costs, to: :outgoings
    delegate :fixed_costs, to: :outgoings

    currency_inputs :lifestyle_costs

    validates :borrowing, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
    validates :interest_rate, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

    def people_attributes=(attributes)
    end

    def lifestyle_costs
      @lifestyle_costs || outgoings.lifestyle_costs
    end

    def initialize(options = {})
      @people = options[:people]
      @people.each {|person| person.affordability = self } if @people # Set up parent relation
      @outgoings = options[:outgoings]
      @interest_rate = options[:interest_rate]
      self.borrowing = options[:borrowing]
      self.two_applicants = options[:two_applicants]
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
      ((total_income - annual_committed_costs) * upper_profit_multiplier).round
    end

    def can_borrow_from
      ((total_income - annual_committed_costs) * lower_profit_multiplier).round
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

    def people_valid?
      # To get a full set of validation errors, we need to run valid? on all
      # objects. people.all?(&:valid) won't run the method on all objects, as it
      # stops as soon as it finds a false.
      people.map(&:valid?).all?
    end

    def valid_for_step2?
      valid?
      errors[:base].empty? && people_valid?
    end

    def valid_for_step3?
      valid?
      errors[:base].empty? && outgoings.valid?
    end

    def valid?
      outgoings.valid? && people_valid? && super
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

    def self.load_from_store(store)
      store = ActiveSupport::HashWithIndifferentAccess[store][:affordability] || {}

      two_applicants = store[:two_applicants] if store[:two_applicants]

      people = []
      if store[:people_attributes]
        if two_applicants == "1"
          people_attributes = store[:people_attributes].values
        else
          people_attributes = store[:people_attributes].values.take(1)
        end

        people = people_attributes.each_with_index.map do |p,i|
          i == 0 ? Person.new(p) : Person.new(p, allow_blanks: true)
        end
      end

      people << Person.new if people.size == 0
      people << Person.new({}, true) if people.size == 1

      if store[:outgoings]
        outgoings = Outgoings.new(store[:outgoings])
      else
        outgoings = Outgoings.new
      end

      borrowing = store[:borrowing] if store[:borrowing]
      interest_rate = store[:interest_rate] if store[:interest_rate]
      lifestyle_costs = store[:lifestyle_costs] if store[:lifestyle_costs]

      model = new(people: people, outgoings: outgoings, borrowing: borrowing, interest_rate: interest_rate, lifestyle_costs: lifestyle_costs, two_applicants: two_applicants)
      model.empty = store.empty?
      model
    end

    def borrowing_formatted
      number_to_currency borrowing, precision: 0, unit: ""
    end

    def lifestyle_costs_formatted
      number_to_currency lifestyle_costs, precision: 0, unit: ""
    end

    def monthly_debt_formatted
      number_to_currency monthly_debt, unit: ""
    end

    def budget_outgoing_formatted
      number_to_currency budget_outgoing
    end

    def budget_leftover_formatted
      number_to_currency budget_leftover
    end

    def can_borrow_from_formatted
      number_to_currency can_borrow_from, precision: 0
    end

    def can_borrow_upto_formatted
      number_to_currency can_borrow_upto, precision: 0
    end

    def over_committed?
      committed_costs + fixed_costs > monthly_net_income
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

    def default_borrowing_amount
      (can_borrow_from + can_borrow_upto) / 2
    end

    private

    def borrowing=(value)
      @borrowing = unformat(value)
    end

    def unformat(value)
      return value unless value.is_a?(String)
      value.gsub(/,/, '')
    end
  end
end
