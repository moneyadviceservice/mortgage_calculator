module MortgageCalculator
  class RepaymentsController < ApplicationController
    def show
      @repayment = RepaymentPresenter.new(Repayment.new)
    end

    def create
      repayment_model = Repayment.new(params[:repayment])

      @repayment = RepaymentPresenter.new(repayment_model)
      @interest_only = InterestOnly.new(params[:repayment])
      @changer = RepaymentPresenter.new(repayment_model.clone.change_interest_rate_by(1))

      unless @repayment.valid?
        render :show
      end
    end

    def next_steps

    end
  end
end
