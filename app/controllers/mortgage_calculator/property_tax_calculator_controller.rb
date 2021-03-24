module MortgageCalculator
  class PropertyTaxCalculatorController < MortgageCalculator::ApplicationController
    include PhaseHelper
    before_action :set_rates

    def resource
      @resource ||= calculator.new
    end
    helper_method :resource

    def create
      @resource = calculator.new(calculator_params)

      render :show if @resource.invalid?
    end

    def bands_to_use
      calculator.banding_for(calculator::STANDARD_BANDS[phase])
    end
    helper_method :bands_to_use

    def completion_date
      return @resource.try(:completion_date) unless @resource.try(:completion_date).nil?
      return calculator_params[:completion_date] unless calculator_params[:completion_date].blank?
      Date.today
    end

    private

    def set_rates
      @rates = calculator.banding_for(
        calculator::STANDARD_BANDS[phase]
      )
      @ftb_rates = calculator.banding_for(
        calculator::FIRST_TIME_BUYER_BANDS[phase]
      )
    end

    def category_id
      'buying-a-home'
    end
    helper_method :category_id

    def calculator_params
      params
        .require(calculator_params_key)
        .permit(:price, :buyer_type, :completion_date)
        .symbolize_keys
    end

    def calculator_params_key
      self.class.name.demodulize.underscore.gsub('_controller', '').singularize
    end
  end
end
