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
      number_to_currency model.debt, unit: nil
    end

    def price
      number_to_currency model.price, unit: nil
    end

    def deposit
      number_to_currency model.deposit, unit: nil
    end

    def term_years
      return nil if model.term_years.blank?

      model.term_years
    end

    def interest_rate
      return nil if model.interest_rate.blank?

      model.interest_rate
    end

    def monthly_payment
      number_to_currency model.monthly_payment, unit: nil
    end

    def total_interest
      number_to_currency model.total_interest, unit: nil
    end

    def total_payable
      number_to_currency model.total_payable, unit: nil
    end

    def self.model_name
      Repayment.model_name
    end

    def to_key
      nil
    end
  end
end
