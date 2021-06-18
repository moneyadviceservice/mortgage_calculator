require 'spec_helper'

module MortgageCalculator
  describe LandTransactionTaxesController do
    routes { MortgageCalculator::Engine.routes }

    describe '#standard_rates' do
      it 'returns the rates for each band' do
        expect(controller.standard_rates).to eq(
          [
            {
              start: 0,
              end: 250_000,
              rate: 0
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

        expect(controller.higher_rates).to eq(
          [
            {
              start: 0,
              end: 180_000,
              rate: 4
            },
            {
              start: 180_000.01,
              end: 250_000,
              rate: 7.5
            },
            {
              start: 250_000.01,
              end: 400_000,
              rate: 9
            },
            {
              start: 400_000.01,
              end: 750_000,
              rate: 11.5
            },
            {
              start: 750_000.01,
              end: 1_500_000,
              rate: 14
            },
            {
              start: 1_500_000.01,
              end: nil,
              rate: 16
            }
          ]
        )
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

      context 'when date is invalid' do
        render_views

        it 'renders show template' do
          post :create, land_transaction_tax: { completion_date: "2021-06-31" }
          expect(response).to render_template('show')
        end
      end
    end
  end
end
