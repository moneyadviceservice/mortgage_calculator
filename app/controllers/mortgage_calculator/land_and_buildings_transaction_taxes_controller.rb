module MortgageCalculator
  class LandAndBuildingsTransactionTaxesController < ::MortgageCalculator::ApplicationController
    before_action :set_rates
    def show
      @lbtt = LandAndBuildingsTransactionTax.new
      respond_to do |format|
        format.html
        format.json { render json: @rates }
      end
    end

    def create
      @lbtt = LandAndBuildingsTransactionTax.new(params[:land_and_buildings_transaction_tax])
      unless @lbtt.valid?
        render :show
      end
    end

    private

    def set_rates
      @rates = MortgageCalculator::LandAndBuildingsTransactionTax.banding_for(
        MortgageCalculator::LandAndBuildingsTransactionTax::STANDARD_BANDS
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
