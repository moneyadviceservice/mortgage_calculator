module MortgageCalculator
  class PersonOne < Person
    validate :validate_positive_total_income

    private

    def validate_positive_total_income
      unless total_income > 0
        errors[:base] << I18n.t("affordability.activemodel.errors.#{self.class.model_name.i18n_key}.base.positive_total_income")
      end
    end
  end
end
