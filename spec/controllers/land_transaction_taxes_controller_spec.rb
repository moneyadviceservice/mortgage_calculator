require 'spec_helper'

module MortgageCalculator
  describe LandTransactionTaxesController do
    routes { MortgageCalculator::Engine.routes }

    describe '#calculator' do
      it 'returns land and buildings transaction tax' do
        expect(controller.calculator).to be(
          MortgageCalculator::LandTransactionTax
        )
      end
    end

    describe '#i18n_locale_namespace' do
      it 'returns I18n key namespace' do
        expect(controller.i18n_locale_namespace).to eq(
          'land_transaction_tax'
        )
      end
    end

    describe '#calculator_form_path' do
      it 'returns the respective form path' do
        expect(controller.calculator_form_path).to eq(
          '/en/mortgage_calculator/land-transaction-tax-calculator'
        )
      end
    end


    describe '#standard_rates' do
      it 'returns the rates for each band' do
        expect(controller.standard_rates).to eq(
          [
            {
              start: 0,
              end: 180_000,
              rate: 0
            },
            {
              start: 180_000.01,
              end: 250_000,
              rate: 3.5
            },
            {
              start: 250_000.01,
              end: 400_000,
              rate: 5
            },
            {
              start: 400_000.01,
              end: 750_000,
              rate: 7.5
            },
            {
              start: 750_000.01,
              end: 1_500_000,
              rate: 10
            },
            {
              start: 1_500_000.01,
              end: nil,
              rate: 12
            }
          ]
        )
      end
    end

    describe '#i18n_locale_namespace' do
      it 'returns land transaction tax' do
        expect(controller.i18n_locale_namespace).to eq('land_transaction_tax')
      end
    end

    describe '#show' do
      it 'responds with 200' do
        get :show
        expect(response).to be_success
      end
    end

    describe '#create' do
      it 'responds with 200' do
        post :create, land_transaction_tax: { price: '200000' }
        expect(response).to be_success
      end

      context 'when price is invalid' do
        render_views

        it 'renders show template' do
          post :create, land_transaction_tax: { price: 'asd' }
          expect(response).to render_template('show')
        end
      end
    end
  end
end
