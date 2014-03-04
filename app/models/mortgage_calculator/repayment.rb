module MortgageCalculator
  class Repayment
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include CurrencyInput::Macro
    include ActiveModel::Validations

    attr_reader :term_years, :interest_rate, :price, :deposit

    currency_inputs :price, :deposit

    validates :term_years, presence: true, numericality: {greater_than: 0}
    validates :price, presence: true
    validates :interest_rate, presence: true, numericality: {greater_than: 0}

    def initialize(options = {})
      self.price = options.fetch(:price){ 0 }
      self.deposit = options.fetch(:deposit){ 0 }
      self.term_years = options.fetch(:term_years){ 25 }
      self.interest_rate = options.fetch(:interest_rate){ 5 }
    end

    def debt
      price - deposit
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

    def persisted?
      false
    end

    def monthly_payment
      monthly_interest / f1
    end

    def total_interest
      (monthly_payment * term_months) - debt
    end

    def total_payable
      debt + total_interest
    end

    def remaining_balances
      [debt] + (1..term_years).map do |year|
        month = year * 12

        a1 = debt * ((1 + monthly_rate) ** month)
        b1 = -monthly_payment
        c1 = ((1 + monthly_rate) ** month) - 1
        d1 = (b1 * c1) / monthly_rate
        a1 + d1
      end
    end

    private

    def term_months
      term_years * 12
    end

    def f1
      1 - ((1 + monthly_rate) ** -(term_months))
    end

    def monthly_rate
      DAYS_IN_A_MONTH * ((interest_rate / 100) / DAYS_IN_A_YEAR)
    end

    def monthly_interest
      debt * monthly_rate
    end
  end
end
