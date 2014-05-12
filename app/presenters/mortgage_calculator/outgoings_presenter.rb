module MortgageCalculator
  class OutgoingsPresenter
    extend ActiveModel::Naming
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :persisted?, to: :model
    delegate :to_key, to: :model

    def initialize(model)
      @model = model
    end

    [:credit_repayments, :utilities, :childcare, :child_maintenance,
     :rent_and_mortgage, :food, :travel, :entertainment].each do |name|
      define_method("#{name}_formatted") do
        number_to_currency model.public_send(name), unit: ""
      end
    end

    def self.model_name
      ActiveModel::Name.new(Outgoings, MortgageCalculator)
    end

    def method_missing(m, *args, &block)
      model.send(m, *args, &block)
    end
  end
end
