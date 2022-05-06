module MortgageCalculator
  class LandTransactionTaxesController < MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::LandTransactionTax

    def show
      @ltt = CALCULATOR.new
    end

    def create
      @ltt = CALCULATOR.new(calculator_params)

      if @ltt.invalid?
        render :show
      end
    end

    def standard_rates
      CALCULATOR.banding_for(CALCULATOR::STANDARD_BANDS)
    end
    helper_method :standard_rates

    def higher_rates
      CALCULATOR.banding_for(CALCULATOR::HIGHER_BANDS)
    end
    helper_method :higher_rates

    def other_countries
      ['england_ni', 'scotland']
    end
    helper_method :other_countries

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

      params.require(:land_transaction_tax).permit(:price, :buyer_type).symbolize_keys
    end
  end
end
