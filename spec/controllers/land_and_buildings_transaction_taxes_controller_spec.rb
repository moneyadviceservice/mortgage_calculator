require 'spec_helper'

module MortgageCalculator
  describe LandAndBuildingsTransactionTaxesController do
    routes { MortgageCalculator::Engine.routes }

    describe '#show' do
      it 'responds with 200' do
        get :show
        expect(response).to be_success
      end
    end

    describe '#create' do
      it 'responds with 200' do
        post :create, land_and_buildings_transaction_tax: { price: "200000" }
        expect(response).to be_success
      end

      context 'when price is invalid' do
        render_views

        it 'renders show template' do
          post :create, land_and_buildings_transaction_tax: { price: "asd" }
          expect(response).to render_template('show')
        end
      end
    end

    describe '#calculator' do
      it 'returns stamp duty' do
        expect(controller.calculator).to be(
          MortgageCalculator::LandAndBuildingsTransactionTax
        )
      end
    end

    describe '#i18n_locale_namespace' do
      it 'returns I18n key namespace' do
        expect(controller.i18n_locale_namespace).to eq(
          'land_and_buildings_transaction_tax'
        )
      end
    end

    describe '#calculator_form_path' do
      it 'returns the respective form path' do
        expect(controller.calculator_form_path).to eq(
          '/en/mortgage_calculator/land_and_buildings_transaction_tax-calculator-scotland'
        )
      end
    end
  end
end
