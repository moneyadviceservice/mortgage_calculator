require 'spec_helper'

module MortgageCalculator
  describe StampDutiesController do
    routes { MortgageCalculator::Engine.routes }

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
    end
  end
end

