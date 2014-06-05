module MortgageCalculator
  class OutgoingsPresenter
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActionView::Helpers::NumberHelper
    include ActiveModel::Serialization

    attr_reader :model

    delegate :persisted?, to: :model
    delegate :to_key, to: :model

    def self.i18n_scope
      "affordability.activemodel"
    end

    def initialize(model)
      @model = model
    end

    [:credit_repayments, :utilities, :childcare, :child_maintenance,
     :rent_and_mortgage, :food, :travel, :entertainment, :holidays].each do |name|
      define_method("#{name}_formatted") do
        number_to_currency model.public_send(name), unit: ""
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

    def self.model_name
      ActiveModel::Name.new(Outgoings, MortgageCalculator)
    end

    def method_missing(m, *args, &block)
      model.send(m, *args, &block)
    end

    private

    def read_attribute_for_serialization(key)
      attributes[key]
    end
  end
end
