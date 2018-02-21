module MortgageCalculator
  class StampDutiesController < ::MortgageCalculator::ApplicationController
    before_action :set_rates

    def show
      @stamp_duty = StampDuty.new
    end

    def create
      @stamp_duty = StampDuty.new(params[:stamp_duty])
      unless @stamp_duty.valid?
        render :show
      end
    end

    private

    def set_rates
      @rates = MortgageCalculator::StampDuty.banding_for(MortgageCalculator::StampDuty::STANDARD_BANDS)
      @ftb_rates = MortgageCalculator::StampDuty.banding_for(MortgageCalculator::StampDuty::FIRST_TIME_BUYER_BANDS)
    end

    def category_id
      'buying-a-home'
    end

    def tool_name
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
