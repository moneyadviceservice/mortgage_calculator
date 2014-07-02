module MortgageCalculator
  class PersonOne < Person
    validate :validate_positive_total_income
    validates :raw_monthly_net_income, presence: { message: I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:monthly_net_income).downcase) }

    private

    def validate_positive_total_income
      unless total_income > 0
        errors[:base] << I18n.t("affordability.activemodel.errors.#{self.class.model_name.i18n_key}.base.positive_total_income")
      end
    end
  end
end
