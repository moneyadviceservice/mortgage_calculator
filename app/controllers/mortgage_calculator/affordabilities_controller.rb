module MortgageCalculator
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    before_filter :no_cache, only: [:step_1, :step_2]

    def step_1
      persist_affordability_params_to_session

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
      persist_affordability_params_to_session
      @affordability = affordability_model

      if request.post?
        if @affordability.valid_for_step3?
          redirect_to step_3_affordability_path
        end
      end
    end

    def step_3
      persist_affordability_params_to_session

      @affordability = affordability_model

      if @affordability.valid_for_step3?
        if @affordability.over_committed?
          render :over_committed
        else
          adjust_interest_rate
        end
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
        @changer = Repayment.new(price: @affordability.repayment.price, interest_rate: @affordability.repayment.interest_rate)
        @changer.change_interest_rate_by(interest_rate_change_amount)
      end

      def interest_rate_change_amount
        2
      end
      helper_method :interest_rate_change_amount
  end
end

