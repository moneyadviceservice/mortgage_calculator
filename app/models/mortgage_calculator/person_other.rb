module MortgageCalculator
  class PersonOther < Person
    validates :annual_income, numericality: {greater_than: 0, message: I18n.t("affordability.activemodel.errors.messages.greater_than", attribute: self.human_attribute_name(:annual_income).downcase)}, if: "monthly_net_income > 0"
    validates :monthly_net_income, numericality: {greater_than: 0, message: I18n.t("affordability.activemodel.errors.messages.greater_than", attribute: self.human_attribute_name(:monthly_net_income).downcase)}, if: "annual_income > 0"

    def initialize(options = {})
      self.annual_income = options[:annual_income].presence || 0
      self.extra_income = options[:extra_income].presence || 0
      self.monthly_net_income = options[:monthly_net_income].presence || 0
    end
  end
end
