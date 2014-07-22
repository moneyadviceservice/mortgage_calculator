module MortgageCalculator
  class PersonOne < Person
    validates :annual_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:annual_income).downcase) } }
    validates :monthly_net_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:monthly_net_income).downcase) } }
  end
end
