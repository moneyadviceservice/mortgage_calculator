module MortgageCalculator
  class Person
    include ActiveModel::Validations

    attr_accessor :annual_income, :extra_income

    validates_presence_of :annual_income

    def initialize(options = {})
      @annual_income = options.fetch(:annual_income){ 0 }
      @extra_income = options.fetch(:extra_income){ 0 }
    end
  end
end
