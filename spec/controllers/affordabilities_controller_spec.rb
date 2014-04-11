require 'spec_helper'

module MortgageCalculator
  describe AffordabilitiesController do
    routes { MortgageCalculator::Engine.routes }

    describe 'when feature is toggled off' do
      it 'the stamp duty calculator is not available' do
        MortgageCalculator.affordability_enabled = false
        Rails.application.reload_routes!

        expect{get :show}.to raise_error(ActionController::RoutingError)

        MortgageCalculator.affordability_enabled = true
        Rails.application.reload_routes!
      end
    end

    describe :show do
      it 'responds with 200' do
        get :show
        expect(response).to be_success
      end
    end

    describe :create do
      it 'responds with 200' do
        post :create, affordability: {people_attributes: {"0"=>{annual_income: "100000", extra_income: "10000"},
                                                          "1"=>{annual_income: "50000", extra_income: "5000"}}, monthly_debt: "1"}
        expect(response).to be_success
      end

      it 'renders the create template' do
        post :create, affordability: {people_attributes: {"0"=>{annual_income: "100000", extra_income: "10000"},
                                                          "1"=>{annual_income: "50000", extra_income: "5000"}}, monthly_debt: "1"}
        expect(response).to render_template('create')
      end
    end
  end
end

