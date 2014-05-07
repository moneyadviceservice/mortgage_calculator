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
        post :create, affordability: {
                        people_attributes: {
                          "0"=>{annual_income: "100000", extra_income: "10000"},
                          "1"=>{annual_income: "50000", extra_income: "5000"}
                        },
                        outgoings: {}
                      }
        expect(response).to be_success
      end

      it 'renders the create template' do
        post :create, affordability: {
                        people_attributes: {
                          "0"=>{annual_income: "100000", extra_income: "10000"},
                          "1"=>{annual_income: "50000", extra_income: "5000"}
                        },
                        outgoings: {}
                      }
        expect(response).to render_template('create')
      end

      context "when custom borrowing amount is entered" do
        it 'sets custom house price' do
          post :create, affordability: {
                          people_attributes: {
                            "0"=>{annual_income: "100000", extra_income: "10000"},
                            "1"=>{annual_income: "50000", extra_income: "5000"}
                          },
                          outgoings: {},
                          borrowing: "550000"
                        }
          expect(response).to be_success
          expect(assigns(:affordability).borrowing).to eql("550,000")
        end
      end

      context "when custom lifestyle amount is entered" do
        it 'sets custom lifestyle amount' do
          post :create, affordability: {
                          people_attributes: {
                            "0"=>{annual_income: "100000", extra_income: "10000"},
                            "1"=>{annual_income: "50000", extra_income: "5000"}
                          },
                          outgoings: {},
                          lifestyle_costs: "3000"
                        }
          expect(response).to be_success
          expect(assigns(:affordability).lifestyle_costs).to eql("3,000")
        end
      end
    end

    describe :next_steps do
      it 'works' do
        get :next_steps
        expect(response).to be_success
      end
    end
  end
end

