module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::LandAndBuildingsTransactionTax
    before_action :set_rates

    def show
      @lbtt = CALCULATOR.new
    end

    def create
      @lbtt = CALCULATOR.new(
        params.require(:land_and_buildings_transaction_tax)
          .permit(:price, :buyer_type)
          .symbolize_keys
      )
      unless @lbtt.valid?
        render :show
      end
    end

    def other_countries
      ['england_ni', 'wales']
    end
    helper_method :other_countries

    private

    def set_rates
      @rates = CALCULATOR.banding_for(
        CALCULATOR::STANDARD_BANDS
      )
      @ftb_rates = CALCULATOR.banding_for(
        CALCULATOR::FIRST_TIME_BUYER_BANDS
      )
    end

    def category_id
      'buying-a-home'
    end

    def tool_name
      I18n.translate('land_and_buildings_transaction_tax.tool_name')
    end
  end
end
