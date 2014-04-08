module MortgageCalculator
  class CalculatorPresenter
    extend ActiveModel::Translation
    include ActionView::Helpers::NumberHelper

    def self.i18n_scope
      "mortgage_calculator.activemodel"
    end

    attr_reader :model

    delegate :persisted?, :valid?, :errors, to: :model

    def initialize(model)
      @model = model
    end

    def self.convert_to_currency(*args)
      args.each do |arg|
        define_method arg do
          number_to_currency(model.send(arg).presence || 0, unit: '')
        end
      end
    end

    def self.model_name
      Repayment.model_name
    end

    def to_key
      nil
    end
  end
end
