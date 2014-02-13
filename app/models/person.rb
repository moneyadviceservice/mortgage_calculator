module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro

    attr_accessor :annual_income, :extra_income

    validates_numericality_of :annual_income, greater_than: 0

    currency_inputs :annual_income, :extra_income

    def initialize(options = {})
      self.annual_income = options.fetch(:annual_income){ 0 }
      self.extra_income = options.fetch(:extra_income){ 0 }
    end
  end
end
