module MortgageCalculator
  class InterestOnly
    include CurrencyInput::Macro

    attr_reader :price, :deposit, :term_years, :interest_rate

    currency_inputs :price, :deposit

    def initialize(options = {})
      self.price = options.fetch(:price)
      self.deposit = options.fetch(:deposit){ 0 }
      @term_years = options.fetch(:term_years){ 25 }
      @interest_rate = options.fetch(:interest_rate){ 5 }
    end

    def debt
      price - deposit
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

