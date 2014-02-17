module MortgageCalculator
  class StampDutiesController < ApplicationController
    def show
      @stamp_duty = StampDuty.new
    end

    def create
      @stamp_duty = StampDuty.new(params[:stamp_duty])
    end
  end
end
