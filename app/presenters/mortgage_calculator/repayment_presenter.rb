module MortgageCalculator
  class RepaymentPresenter
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

    def debt
      convert_to_currency(model.debt)
    end

    def price
      convert_to_currency(model.price)
    end

    def deposit
      convert_to_currency(model.deposit)
    end

    def term_years
      model.term_years.presence
    end

    def interest_rate
      model.interest_rate.presence
    end

    def monthly_payment
      convert_to_currency(model.monthly_payment)
    end

    def total_interest
      convert_to_currency(model.total_interest)
    end

    def total_payable
      convert_to_currency(model.total_payable)
    end

    def convert_to_currency(value)
      number_to_currency(value.presence || 0, unit: '')
    end

    def self.model_name
      Repayment.model_name
    end

    def to_key
      nil
    end
  end
end
