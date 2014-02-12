module MortgageCalculator
  class Affordability
    INCOME_MULTIPLIER = 4.5

    attr_reader :annual_income, :extra_income, :monthly_debt

    def initialize(options = {})
      @annual_income = options.fetch(:annual_income){ 0 }
      @extra_income = options.fetch(:extra_income){ 0 }
      @monthly_debt = options.fetch(:monthly_debt){ 0 }
    end

    def total_income
      annual_income + extra_income
    end

    def can_borrow
      ((total_income) - (12 * monthly_debt)) * INCOME_MULTIPLIER
    end
  end
end
