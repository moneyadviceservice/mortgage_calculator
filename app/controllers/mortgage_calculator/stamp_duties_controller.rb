module MortgageCalculator
  class StampDutiesController < ApplicationController
    def show
      @stamp_duty = StampDutyPresenter.new(StampDuty.new)
    end

    def create
      @stamp_duty = StampDutyPresenter.new(StampDuty.new(params[:stamp_duty]))
    end
  end
end
