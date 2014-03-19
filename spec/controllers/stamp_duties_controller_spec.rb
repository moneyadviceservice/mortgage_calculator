require 'spec_helper'

module MortgageCalculator
  describe StampDutiesController do
    routes { MortgageCalculator::Engine.routes }

    before :each do
      pending 'stamp duty to be launched at a later date'
    end

    describe :show do
      it 'responds with 200' do
        get :show
        response.should be_success
      end
    end

    describe :create do
      it 'responds with 200' do
        post :create, stamp_duty: { price: "200000" }
        response.should be_success
      end

      context 'when the price is blank' do
        it 'renders show template' do
          post :create, stamp_duty: { price: "" }
          response.should render_template('show')
        end
      end
    end
  end
end

