module MortgageCalculator
  class Outgoings
    extend ActiveModel::Translation
    include CurrencyInput::Macro
    include ActiveModel::Validations
    include ActionView::Helpers::NumberHelper
    extend ActiveModel::Naming
    include ActiveModel::Serialization

    def self.i18n_scope
      "affordability.activemodel"
    end

    attr_accessor :credit_repayments, :utilities, :childcare,
                  :child_maintenance, :rent_and_mortgage,
                  :food, :travel, :entertainment, :holidays

    currency_inputs :credit_repayments, :utilities, :childcare,
                    :child_maintenance, :rent_and_mortgage,
                    :food, :travel, :entertainment, :holidays

    validates :credit_repayments, numericality: true
    validates :utilities, numericality: true
    validates :childcare, numericality: true
    validates :child_maintenance, numericality: true
    validates :rent_and_mortgage, numericality: true
    validates :food, numericality: true
    validates :travel, numericality: true
    validates :entertainment, numericality: true
    validates :holidays, numericality: true

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
      self.holidays = attributes[:holidays] || 0
    end

    def committed_costs
      credit_repayments + child_maintenance
    end

    def fixed_costs
      utilities + childcare + travel
    end

    def lifestyle_costs
      food + entertainment + holidays
    end

    def to_key
      nil
    end

    def persisted?
      false
    end

    [:credit_repayments, :utilities, :childcare, :child_maintenance,
     :rent_and_mortgage, :food, :travel, :entertainment, :holidays].each do |name|
      define_method("#{name}_formatted") do
        number_to_currency public_send(name), unit: ""
      end
    end

    def attributes
      {
        "credit_repayments" => number_to_currency(credit_repayments, unit: "", delimiter: nil),
        "utilities" => number_to_currency(utilities, unit: "", delimiter: nil),
        "childcare" => number_to_currency(childcare, unit: "", delimiter: nil),
        "child_maintenance" => number_to_currency(child_maintenance, unit: "", delimiter: nil),
        "rent_and_mortgage" => number_to_currency(rent_and_mortgage, unit: "", delimiter: nil),
        "food" => number_to_currency(food, unit: "", delimiter: nil),
        "travel" => number_to_currency(travel, unit: "", delimiter: nil),
        "entertainment" => number_to_currency(entertainment, unit: "", delimiter: nil),
        "holidays" => number_to_currency(holidays, unit: "", delimiter: nil)
      }
    end

    private

    def read_attribute_for_serialization(key)
      attributes[key]
    end
  end
end
