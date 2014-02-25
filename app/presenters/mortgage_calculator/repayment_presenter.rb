module MortgageCalculator
  class RepaymentPresenter
    include ActionView::Helpers::NumberHelper

    attr_reader :model

    delegate :persisted?, :valid?, :errors, to: :model

    def initialize(model)
      @model = model
    end

    def debt
      number_to_currency model.debt, unit: nil
    end

    def term_years
      return nil if model.term_years.blank?

      model.term_years
    end

    def interest_rate
      return nil if model.interest_rate.blank?

      number_to_human model.interest_rate, strip_insignificant_zeros: true
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
