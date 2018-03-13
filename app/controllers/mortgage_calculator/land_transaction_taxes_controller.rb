module MortgageCalculator
  class LandTransactionTaxesController < ::MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::LandTransactionTax
    before_action :set_rates
    def show
      @ltt = CALCULATOR.new
    end

    def create
      @ltt = CALCULATOR.new(
        params.require(:land_transaction_tax)
        .permit(:price, :buyer_type)
        .symbolize_keys
      )
      unless @ltt.valid?
        render :show
      end
    end

    private

    def set_rates
      @rates = CALCULATOR.banding_for(
        CALCULATOR::STANDARD_BANDS
      )
    end

    def category_id
      'buying-a-home'
    end

    def tool_name
      I18n.translate('land_transaction_tax.tool_name')
    end
  end
end
