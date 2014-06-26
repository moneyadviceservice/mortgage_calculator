module MortgageCalculator
  class PersonOther < Person
    def initialize(options = {})
      self.annual_income = options[:annual_income].presence || 0
      self.extra_income = options[:extra_income].presence || 0
      self.monthly_net_income = options[:monthly_net_income].presence || 0
    end
  end
end
