module MortgageCalculator
  module StampDutiesHelper
    include PhaseHelper

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
      resource.first_time_buy?
    end

    def outside_first_time_rate?
      resource.first_time_ineligible?
    end

    def completion_date
      resource.completion_date
    end

    def calculator_config_json
      calculator = MortgageCalculator::StampDuty
      {
        tool: 'stampDuty',
        completion_date: completion_date,
        standard: calculator::STANDARD_BANDS[phase],
        ftb: calculator::FIRST_TIME_BUYER_BANDS[phase],
        second_home_tax_rate: calculator::SECOND_HOME_ADDITIONAL_TAX,
        second_home_threshold: calculator::SECOND_HOME_THRESHOLD,
        first_time_buyer_threshold: calculator::FIRST_TIME_BUYER_THRESHOLD
      }.to_json
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
