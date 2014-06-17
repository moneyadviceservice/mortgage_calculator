module MortgageCalculator
  # Load order issue - subclass a class explicitly
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    def step_1
      @affordability = AffordabilityPresenter.new(affordability_model)

      @affordability.valid? if affordability_params
    end

    def step_2
      @affordability = AffordabilityPresenter.new(affordability_model)
      @affordability.save(session)

      unless @affordability.valid_for_step2?
        persist_affordability_params_to_flash
        redirect_to step_1_affordability_path
      end
    end

    def step_3
      @affordability = AffordabilityPresenter.new(affordability_model)
      @affordability.save(session)

      if @affordability.valid_for_step3?
        adjust_interest_rate
      else
        persist_affordability_params_to_flash
        redirect_to step_2_affordability_path
      end
    end

    def next_steps
    end

    def tool_name
      I18n.translate('affordability.tool_name')
    end

    private

      def affordability_params
        params[:affordability] || session[:affordability]
      end

      def persist_affordability_params_to_flash
        session[:affordability] = params[:affordability]
      end

      def affordability_model
        hash = (session[:affordability] || {}).deep_merge(params[:affordability] || {})
        hash = ActiveSupport::HashWithIndifferentAccess.new({affordability: hash})

        Affordability.load_from_store(hash)
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

