module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::ApplicationController
    CALCULATOR = MortgageCalculator::LandAndBuildingsTransactionTax
    before_action :set_rates
    def show
      @lbtt = CALCULATOR.new
      @javascript_config = {
        standard: CALCULATOR::STANDARD_BANDS,
        second_home_tax_rate: CALCULATOR::SECOND_HOME_ADDITIONAL_TAX,
        second_home_threshold: CALCULATOR::SECOND_HOME_THRESHOLD
      }
    end

    def create
      @lbtt = CALCULATOR.new(
        params[:land_and_buildings_transaction_tax]
      )
      unless @lbtt.valid?
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
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
