module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::ApplicationController
    def show
      @lbtt = LandAndBuildingsTransactionTax.new
      @rates = MortgageCalculator::LandAndBuildingsTransactionTax::STANDARD_BANDS
    end

    def create
      @lbtt = LandAndBuildingsTransactionTax.new(params[:stamp_duty])
      @rates = MortgageCalculator::LandAndBuildingsTransactionTax::STANDARD_BANDS
      unless @lbtt.valid?
        render :show
      end
    end

    private

    def category_id
      "buying-a-home"
    end

    def tool_name
      I18n.translate('stamp_duty.tool_name')
    end
  end
end
