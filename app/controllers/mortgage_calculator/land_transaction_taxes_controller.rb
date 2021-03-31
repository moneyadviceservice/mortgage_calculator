module MortgageCalculator
  class LandTransactionTaxesController < MortgageCalculator::ApplicationController
    include PhaseHelper
    CALCULATOR = MortgageCalculator::LandTransactionTax

    def show
      @ltt = CALCULATOR.new
    end

    def create
      @ltt = CALCULATOR.new(calculator_params)

      if @ltt.invalid?
        @ltt.completion_date = Date.tomorrow if @ltt.errors.key?(:completion_date)
        render :show
      end
    end

    def standard_rates
      CALCULATOR.banding_for(CALCULATOR::STANDARD_BANDS[phase])
    end
    helper_method :standard_rates

    def higher_rates
      CALCULATOR.banding_for(CALCULATOR::HIGHER_BANDS[phase])
    end
    helper_method :higher_rates

    def other_countries
      ['england_ni', 'scotland']
    end
    helper_method :other_countries

    def completion_date
      return @ltt.try(:completion_date) unless @ltt.nil? || @ltt.completion_date.nil?
      return calculator_params[:completion_date] if calculator_params[:completion_date].present?

      Time.zone.today
    end
    helper_method :completion_date

    private

    def category_id
      'buying-a-home'
    end
    helper_method :category_id

    def tool_name
      I18n.translate('land_transaction_tax.tool_name')
    end

    def calculator_params
      return {} unless params.key?(:land_transaction_tax)

      y = params[:land_transaction_tax]["completion_date(1i)"].to_i
      m = params[:land_transaction_tax]["completion_date(2i)"].to_i
      d = params[:land_transaction_tax]["completion_date(3i)"].to_i

      completion_date = Date.valid_date?(y.to_i, m.to_i, d.to_i) ? "#{y}-#{m}-#{d}".to_date : "#{y}-#{m}-#{d}"

      # Allow invalid dates here, so the model picks them up
      params.require(:land_transaction_tax)
            .merge(completion_date: completion_date)
            .except(:"completion_date(1i)", :"completion_date(2i)", :"completion_date(3i)")
            .permit(:price, :buyer_type, :completion_date)
            .symbolize_keys
    end
  end
end
