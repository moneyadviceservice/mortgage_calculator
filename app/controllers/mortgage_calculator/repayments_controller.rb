module MortgageCalculator
  class RepaymentsController < ApplicationController
    def show
      @repayment = RepaymentPresenter.new(Repayment.new)
      repayment
      interest_only
      changer
    end

    def create
      repayment
      interest_only
      changer
      unless @repayment.valid?
        render :show
      end
    end

    def next_steps
    end


    private

      def repayment_params
        params[:repayment] || {price: 0, deposit: 0}
      end

      def repayment_model
        Repayment.new(repayment_params)
      end

      def repayment
        @repayment = RepaymentPresenter.new(repayment_model)
      end

      def interest_only
        @interest_only = InterestOnly.new(repayment_params)
      end

      def changer
        @changer = RepaymentPresenter.new(repayment_model.clone.change_interest_rate_by(1))
      end

  end
end
