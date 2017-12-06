module MortgageCalculator
  class StampDutiesController < ::MortgageCalculator::ApplicationController
    def show
      @stamp_duty = StampDuty.new
      @rates = MortgageCalculator::StampDuty::STANDARD_BANDS
    end

    def create
      @stamp_duty = StampDuty.new(params[:stamp_duty])
      @rates = MortgageCalculator::StampDuty::STANDARD_BANDS
      unless @stamp_duty.valid?
        render :show
      end
    end

    private

    def category_id
      "buying-a-home"
    end

    def tool_name
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
