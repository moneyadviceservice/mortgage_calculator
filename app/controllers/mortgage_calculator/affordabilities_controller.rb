module MortgageCalculator
  # Load order issue - subclass a class explicitly
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    def step_1
      @affordability = AffordabilityPresenter.new(affordability_model)

      @affordability.valid? if affordability_params

      adjust_interest_rate
    end

    def step_2
      @affordability = AffordabilityPresenter.new(affordability_model)

      unless @affordability.valid?
        flash[:params] = {}
        flash[:params][:affordability] = params[:affordability]
        redirect_to step_1_affordability_path
      end
    end

    def step_3
      @affordability = AffordabilityPresenter.new(affordability_model)

      if @affordability.valid?
        adjust_interest_rate
      else
        render :step_2
      end
    end

    def next_steps
    end

    def tool_name
      I18n.translate('affordability.tool_name')
    end

    private

      def affordability_params
        flash[:params] ||= {}
        params[:affordability] || flash[:params][:affordability]
      end

      def affordability_model
        Affordability.new(people_models, outgoings_model, borrowing: borrowing_params, lifestyle_costs: lifestyle_params, interest_rate: interest_rate_params)
      end

      def outgoings_model
        if outgoings_params
          OutgoingsPresenter.new(Outgoings.new(outgoings_params))
        else
          OutgoingsPresenter.new(Outgoings.new)
        end
      end

      def people_models
        return affordability_params[:people_attributes].values.map{|p| PersonPresenter.new(Person.new(p))} if affordability_params
        return [PersonPresenter.new(Person.new), PersonPresenter.new(Person.new)]
      end

      def outgoings_params
        affordability_params[:outgoings] if affordability_params
      end

      def borrowing_params
        affordability_params[:borrowing] if affordability_params
      end

      def lifestyle_params
        affordability_params[:lifestyle_costs] if affordability_params
      end

      def interest_rate_params
        affordability_params[:interest_rate] if affordability_params
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

