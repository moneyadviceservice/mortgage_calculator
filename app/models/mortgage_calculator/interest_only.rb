module MortgageCalculator
  class InterestOnly
    include CurrencyInput::Macro
    include MortgageCalculator::Defaults

    attr_reader :price, :deposit, :term_years, :interest_rate

    currency_inputs :price, :deposit

    def initialize(options = {})
      self.price = options[:price].presence || 0
      self.deposit = options[:deposit].presence || 0
      self.term_years = options[:term_years].presence || DEFAULT_ANNUAL_TERM_YEARS
      self.interest_rate = options[:interest_rate].presence || DEFAULT_ANNUAL_INTEREST_RATE
    end

    def term_years=(value)
      @term_years = value.to_i if value.present?
    end

    def interest_rate=(value)
      @interest_rate = value.to_f if value.present?
    end

    def debt
      price - deposit
    rescue
      BigDecimal.new(0)
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

    def change_interest_rate_by(val)
      @interest_rate += val
      self
    end
  end
end
