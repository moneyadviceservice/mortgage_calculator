module MortgageCalculator
  class RepaymentPresenter < CalculatorPresenter

    convert_to_currency :debt, :price, :deposit,
       :monthly_payment, :total_interest, :total_payable

    def term_years
      model.term_years.presence
    end

    def interest_rate
      model.interest_rate.presence
    end

    def self.model_name
      Repayment.model_name
    end

  end
end
