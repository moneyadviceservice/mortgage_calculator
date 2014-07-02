module MortgageCalculator
  class PersonOther < Person
    validates :raw_monthly_net_income, presence: { message: I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:monthly_net_income).downcase) }

    def initialize(options = {})
      self.annual_income = options[:annual_income].presence || 0
      self.extra_income = options[:extra_income].presence || 0
      self.monthly_net_income = options[:monthly_net_income].presence || 0
    end
  end
end
