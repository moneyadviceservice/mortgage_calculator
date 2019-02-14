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
  end
end
