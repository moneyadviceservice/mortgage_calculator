module MortgageCalculator
  class Person
    attr_reader :annual_income, :extra_income

    def initialize(options = {})
      @annual_income = options.fetch(:annual_income){ 0 }
      @extra_income = options.fetch(:extra_income){ 0 }
    end
  end
end
