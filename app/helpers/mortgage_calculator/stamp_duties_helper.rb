module MortgageCalculator
  module StampDutiesHelper
    def band(num1, num2)
      return maximum_band(num1 - 1) if num2.nil?
      "#{formatted_currency(num1)} - #{formatted_currency(num2)}"
    end

    private
    def maximum_band(num)
      I18n.t('stamp_duty.table.over_million', number: num/1_000_000.to_f)
    end

    def formatted_currency(num)
      number_to_currency(num, precision: 0)
    end
  end
end

