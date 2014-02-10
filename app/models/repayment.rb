module MortgageCalculator
  class Repayment
    attr_reader :debt, :term_years, :interest_rate

    def initialize(options = {})
      @debt = options.fetch(:debt)
      @term_years = options.fetch(:term_years)
      @interest_rate = options.fetch(:interest_rate)
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
      array = [debt]

      (1..term_years).each do |year|
        month = year * 12

        a1 = debt * ((1 + monthly_rate) ** month)
        b1 = -monthly_payment
        c1 = ((1 + monthly_rate) ** month) - 1
        d1 = (b1 * c1) / monthly_rate
        outstanding_balance = a1 + d1

        array.push outstanding_balance
      end

      array
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
