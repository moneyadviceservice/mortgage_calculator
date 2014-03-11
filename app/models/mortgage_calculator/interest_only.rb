module MortgageCalculator
  class InterestOnly
    include CurrencyInput::Macro

    attr_reader :price, :deposit, :term_years, :interest_rate

    currency_inputs :price, :deposit

    def initialize(options = {})
      self.price = options.fetch(:price)
      self.deposit = options.fetch(:deposit){ 0 }
      self.term_years = options.fetch(:term_years){ 25 }
      self.interest_rate = options.fetch(:interest_rate){ 5 }
    end

    def term_years=(value)
      @term_years = if value.present?
        value.to_i
      else
        nil
      end
    end

    def interest_rate=(value)
      @interest_rate = if value.present?
        value.to_f
      else
        nil
      end
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

