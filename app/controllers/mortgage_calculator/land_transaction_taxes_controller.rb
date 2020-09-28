module MortgageCalculator
  class LandTransactionTaxesController < MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::LandTransactionTax

    def show
      @ltt = CALCULATOR.new
    end

    def create
      @ltt = CALCULATOR.new(
        params.require(:land_transaction_tax)
          .permit(:price, :buyer_type)
          .symbolize_keys
      )

      render :show unless @ltt.valid?
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
  end
end
