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

      if @resource.invalid?
        @resource.completion_date = Date.tomorrow if @resource.errors.keys.include? :completion_date
        render :show
      end
    end

    def bands_to_use
      calculator.banding_for(calculator::STANDARD_BANDS[phase])
    end
    helper_method :bands_to_use

    def completion_date
      return @resource.try(:completion_date) unless @resource.try(:completion_date).nil?
      return calculator_params[:completion_date] if calculator_params[:completion_date].present?

      Time.zone.today
    end
    helper_method :completion_date

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
      return {} unless params.key?(calculator_params_key)

      y = params[calculator_params_key]["completion_date(1i)"].to_i
      m = params[calculator_params_key]["completion_date(2i)"].to_i
      d = params[calculator_params_key]["completion_date(3i)"].to_i

      completion_date = Date.valid_date?(y.to_i, m.to_i, d.to_i) ? "#{y}-#{m}-#{d}".to_date : "#{y}-#{m}-#{d}"

      #Allow invalid dates here, so the model picks them up
      params.require(calculator_params_key)
                 .merge(:completion_date => completion_date)
                 .except(:"completion_date(1i)", :"completion_date(2i)", :"completion_date(3i)")
                 .permit(:price, :buyer_type, :completion_date)
                 .symbolize_keys
    end

    def calculator_params_key
      self.class.name.demodulize.underscore.gsub('_controller', '').singularize
    end
  end
end
