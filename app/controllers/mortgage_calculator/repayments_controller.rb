module MortgageCalculator
  class RepaymentsController < ApplicationController
    def show
      @repayment = RepaymentPresenter.new(Repayment.new)
    end

    def create
      @repayment = RepaymentPresenter.new(Repayment.new(params[:repayment]))
      @interest_only = InterestOnly.new(params[:repayment])

      unless @repayment.valid?
        render :show
      end
    end
  end
end
