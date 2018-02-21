module MortgageCalculator
  module StampDutiesHelper
    def band(num1, num2)
      num1 = num1.ceil
      return maximum_band(num1 - 1) if num2.nil?
      "#{formatted_currency(num1)} - #{formatted_currency(num2)}"
    end

    def second_home_threshold
      formatted_currency(
        MortgageCalculator::StampDuty::SECOND_HOME_THRESHOLD
      )
    end

    def ftb_threshold
      formatted_currency(
        MortgageCalculator::StampDuty::FIRST_TIME_BUYER_THRESHOLD
      )
    end

    def second_home_rate(rate)
      rate + MortgageCalculator::StampDuty::SECOND_HOME_ADDITIONAL_TAX
    end

    def first_time_buyer?
      @stamp_duty.first_time_buy?
    end

    def outside_first_time_rate?
      @stamp_duty.first_time_ineligible?
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
