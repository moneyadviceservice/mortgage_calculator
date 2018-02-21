module MortgageCalculator
  class StampDutiesController < ::MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::StampDuty
    before_action :set_rates

    def show
      @stamp_duty = StampDuty.new
      @javascript_config = {
        standard: CALCULATOR::STANDARD_BANDS,
        ftb: CALCULATOR::FIRST_TIME_BUYER_BANDS,
        second_home_tax_rate: CALCULATOR::SECOND_HOME_THRESHOLD,
        second_home_threshold: CALCULATOR::SECOND_HOME_ADDITIONAL_TAX,
        first_time_buyer_threshold: CALCULATOR::FIRST_TIME_BUYER_THRESHOLD
      }
    end

    def create
      @stamp_duty = CALCULATOR.new(params[:stamp_duty])
      unless @stamp_duty.valid?
        render :show
      end
    end

    private

    def set_rates
      @rates = CALCULATOR.banding_for(
        CALCULATOR::STANDARD_BANDS
      )
      @ftb_rates = CALCULATOR.banding_for(
        CALCULATOR::FIRST_TIME_BUYER_BANDS
      )
    end

    def category_id
      'buying-a-home'
    end

    def tool_name
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
