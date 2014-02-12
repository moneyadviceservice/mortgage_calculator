module MortgageCalculator
  class Affordability
    INCOME_MULTIPLIER = 4.5
    private_constant :INCOME_MULTIPLIER

    attr_reader :people, :monthly_debt

    def initialize(people, monthly_debt)
      @people = people
      @monthly_debt = monthly_debt
    end

    def total_income
      @total_income ||= people.inject(0){|sum, p| sum + p.annual_income + p.extra_income}
    end

    def can_borrow
      @can_borrow ||= ((total_income) - (12 * monthly_debt)) * INCOME_MULTIPLIER
    end

    def number_of_applicants
      people.length
    end
  end
end
