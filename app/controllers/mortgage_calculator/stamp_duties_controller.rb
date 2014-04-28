module MortgageCalculator
  class StampDutiesController < ::MortgageCalculator::ApplicationController
    def show
      @stamp_duty = StampDutyPresenter.new(StampDuty.new)
    end

    def create
      @stamp_duty = StampDutyPresenter.new(StampDuty.new(params[:stamp_duty]))

      unless @stamp_duty.valid?
        render :show
      end
    end

    def next_steps
    end

  private

    def tool_name
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
