module MortgageCalculator
  class PropertyTaxCalculatorController < MortgageCalculator::ApplicationController
    before_action :set_rates

    def resource
      @resource ||= calculator.new
    end
    helper_method :resource

    def create
      @resource = calculator.new(calculator_params)

      if @resource.invalid?
        render :show
      end
    end

    def bands_to_use
      calculator.banding_for(calculator::STANDARD_BANDS)
    end
    helper_method :bands_to_use

    private

    def set_rates
      @rates = calculator.banding_for(calculator::STANDARD_BANDS)
      @ftb_rates = calculator.banding_for(calculator::FIRST_TIME_BUYER_BANDS)
    end

    def category_id
      'buying-a-home'
    end
    helper_method :category_id

    def calculator_params
      return {} unless params.key?(calculator_params_key)

      params.require(calculator_params_key).permit(:price, :buyer_type).symbolize_keys
    end

    def calculator_params_key
      self.class.name.demodulize.underscore.gsub('_controller', '').singularize
    end
  end
end
