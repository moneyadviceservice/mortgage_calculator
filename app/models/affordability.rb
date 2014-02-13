module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro

    INCOME_MULTIPLIER = 4.5
    private_constant :INCOME_MULTIPLIER

    attr_reader :people, :monthly_debt

    currency_inputs :monthly_debt

    def initialize(people, monthly_debt = 0)
      @people = people
      @monthly_debt = monthly_debt
    end

    def total_income
      @total_income ||= people.inject(0){|sum, p| sum + p.annual_income + p.extra_income}
    end

    def can_borrow
      @can_borrow ||= ((total_income) - (12 * monthly_debt)) * income_multiplier
    end

    def number_of_applicants
      people.length
    end

  private

    def income_multiplier
      INCOME_MULTIPLIER
    end
  end
end
