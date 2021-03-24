module MortgageCalculator
  class LandTransactionTaxesController < MortgageCalculator::ApplicationController
    include PhaseHelper
    CALCULATOR = MortgageCalculator::LandTransactionTax

    def show
      @ltt = CALCULATOR.new
    end

    def create
      @ltt = CALCULATOR.new(calculator_params)

      render :show unless @ltt.valid?
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

    private

    def completion_date
      return @ltt.try(:completion_date) if @resource.completion_date.present?
      return calculator_params[:completion_date] if calculator_params[:completion_date].present?
      Date.today
    end

    def category_id
      'buying-a-home'
    end
    helper_method :category_id

    def tool_name
      I18n.translate('land_transaction_tax.tool_name')
    end

    def calculator_params
      params.require(:land_transaction_tax)
          .permit(:price, :buyer_type, :completion_date)
          .symbolize_keys
    end
  end
end
