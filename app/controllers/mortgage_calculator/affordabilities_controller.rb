module MortgageCalculator
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    before_action :no_cache, only: [:step_1, :step_2]
    before_action :persist_affordability_params_to_session,
      only: [:step_1, :step_2, :step_3]
    def step_1
      @affordability = affordability_model

      if request.post?
        unless @affordability.empty?
          if @affordability.valid_for_step2?
            redirect_to step_2_affordability_path
          end
        end
      end
    end

    def step_2
      @affordability = affordability_model

      if request.post?
        if @affordability.valid_for_step3?
          redirect_to step_3_affordability_path
        end
      end
    end

    def step_3
      @affordability = affordability_model

      if @affordability.over_committed?
        render :over_committed
      else
        adjust_interest_rate
      end
    end

    def next_steps
      @risk_level = affordability_model.risk_level
    end

    def tool_name
      I18n.translate('affordability.tool_name')
    end

    private
      def category_id
        "help-with-mortgages"
      end

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
        @changer = @affordability.repayment
                                 .dup
                                 .change_interest_rate_by(interest_rate_change_amount)
      end

      def interest_rate_change_amount
        MortgageCalculator::Defaults::INTEREST_RATE_CHANGE_AMOUNT
      end
      helper_method :interest_rate_change_amount
  end
end
