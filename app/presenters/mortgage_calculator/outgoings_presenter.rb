module MortgageCalculator
  class OutgoingsPresenter
    extend ActiveModel::Naming
    include ActionView::Helpers::NumberHelper
    include ActiveModel::Serialization

    attr_reader :model

    delegate :persisted?, to: :model
    delegate :to_key, to: :model

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
        "credit_repayments" => credit_repayments_formatted,
        "utilities" => utilities_formatted,
        "childcare" => childcare_formatted,
        "child_maintenance" => child_maintenance_formatted,
        "rent_and_mortgage" => rent_and_mortgage_formatted,
        "food" => food_formatted,
        "travel" => travel_formatted,
        "entertainment" => entertainment_formatted,
        "holidays" => holidays_formatted
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
