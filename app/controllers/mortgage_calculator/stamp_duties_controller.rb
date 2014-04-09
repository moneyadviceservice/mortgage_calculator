module MortgageCalculator
  class StampDutiesController < ApplicationController
    def show
      MortgageCalculator.stamp_duty_welsh_fix.call(@tool, I18n.locale)
      @stamp_duty = StampDutyPresenter.new(StampDuty.new)
    end

    def create
      MortgageCalculator.stamp_duty_welsh_fix.call(@tool, I18n.locale)
      @stamp_duty = StampDutyPresenter.new(StampDuty.new(params[:stamp_duty]))

      unless @stamp_duty.valid?
        render :show
      end
    end

    def next_steps
    end
  end
end
