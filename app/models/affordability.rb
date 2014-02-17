module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro

    attr_reader :people, :monthly_debt

    currency_inputs :monthly_debt

    def initialize(people, monthly_debt = 0)
      @people = people
      @monthly_debt = monthly_debt
    end

    def total_income
      @total_income ||= people.inject(0){|sum, p| sum + p.annual_income + p.extra_income}
    end

    def can_borrow_from
      @can_borrow_from ||= ((total_income) - (12 * monthly_debt)) * lower_profit_multiplier
    end

    def can_borrow_upto
      @can_borrow_upto ||= ((total_income) - (12 * monthly_debt)) * upper_profit_multiplier
    end

    def number_of_applicants
      people.length
    end

  private

    def lower_profit_multiplier
      3
    end

    def upper_profit_multiplier
      4
    end
  end
end
