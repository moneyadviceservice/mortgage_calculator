module MortgageCalculator
  class TransactionTaxCalculatorController < MortgageCalculator::ApplicationController
    def resource
      @resource ||= calculator.new
    end
    helper_method :resource

    def create
      @resource = calculator.new(calculator_params)

      render :show if @resource.invalid?
    end

    def standard_rates
      calculator.banding_for(calculator::STANDARD_BANDS)
    end
    helper_method :standard_rates

    private

    def category_id
      'buying-a-home'
    end
    helper_method :category_id

    def calculator_params
      params
        .require(calculator_params_key)
        .permit(:price, :buyer_type)
        .symbolize_keys
    end

    def calculator_params_key
      self.class.name.demodulize.underscore.gsub('_controller', '').singularize
    end
  end
end
