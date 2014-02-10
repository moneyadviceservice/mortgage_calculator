module MortgageCalculator
  class InterestOnly
    attr_reader :debt, :term_years, :interest_rate

    def initialize(options = {})
      @debt = options[:debt]
      @term_years = options[:term_years]
      @interest_rate = options[:interest_rate]
    end

    def monthly_payment
      (debt * interest_rate / 100) / 12
    end

    def total_interest
      monthly_payment * 12 * term_years
    end

    def total_payable
      total_interest + debt
    end
  end
end

