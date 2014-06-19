module MortgageCalculator
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    before_filter :no_cache, only: [:step_1, :step_2]

    def step_1
      response.headers["Cache-Control"] = "no-store"
      @affordability = AffordabilityPresenter.new(affordability_model)
      @affordability.valid? unless @affordability.empty?
    end

    def step_2
      response.headers["Cache-Control"] = "no-store"
      persist_affordability_params_to_session

      @affordability = AffordabilityPresenter.new(affordability_model)

      unless @affordability.valid_for_step2?
        redirect_to step_1_affordability_path
      end
    end

    def step_3
      persist_affordability_params_to_session

      @affordability = AffordabilityPresenter.new(affordability_model)

      if @affordability.valid_for_step3?
        adjust_interest_rate
      else
        redirect_to step_2_affordability_path
      end
    end

    def next_steps
    end

    def tool_name
      I18n.translate('affordability.tool_name')
    end

    private

      def no_cache
        response.headers["Cache-Control"] = "no-store"
      end

      def persist_affordability_params_to_session
        session[:affordability] ||= {}
        session[:affordability] = session[:affordability].deep_merge(params[:affordability] || {})
      end

      def affordability_model
        Affordability.load_from_store(session)
      end

      def adjust_interest_rate
        @changer = Repayment.new(price: @affordability.repayment.price, interest_rate: @affordability.repayment.interest_rate)
        @changer.change_interest_rate_by(interest_rate_change_amount)
      end

      def interest_rate_change_amount
        2
      end
      helper_method :interest_rate_change_amount
  end
end

