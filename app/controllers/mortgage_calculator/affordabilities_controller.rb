module MortgageCalculator
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    before_action :no_cache, only: %i[step_1 step_2]
    before_action :persist_affordability_params_to_session,
                  only: %i[step_1 step_2 step_3]
    def step_1
      @affordability = affordability_model
      return if !request.post? || @affordability.empty?

      redirect_to step_2_affordability_path if @affordability.valid_for_step2?
    end

    def step_2
      @affordability = affordability_model
      return unless request.post?

      redirect_to step_3_affordability_path if @affordability.valid_for_step3?
    end

    def step_3
      @affordability = affordability_model

      if @affordability.over_committed?
        render :over_committed
      else
        @changer = adjust_interest_rate
      end
    end

    def next_steps
      affordability = affordability_model

      @risk_level =
        if affordability.empty?
          :default
        else
          affordability.risk_level
        end
    end

    def tool_name
      I18n.translate('affordability.tool_name')
    end

    private

    def category_id
      'help-with-mortgages'
    end

    def no_cache
      response.headers['Cache-Control'] = 'no-store'
    end

    def persist_affordability_params_to_session
      session[:affordability] ||= {}
      session[:affordability].deep_merge!(affordability_params)
    end

    def affordability_params
      params[:affordability] || {}
    end

    def affordability_model
      Affordability.load_from_store(session)
    end

    def adjust_interest_rate
      @affordability.repayment
                    .dup
                    .change_interest_rate_by(interest_rate_change_amount)
    end

    def interest_rate_change_amount
      MortgageCalculator::Defaults::INTEREST_RATE_CHANGE_AMOUNT
    end
    helper_method :interest_rate_change_amount
  end
end
