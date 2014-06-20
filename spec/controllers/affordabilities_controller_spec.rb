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

    describe '#step_1' do
      it 'responds with 200' do
        get :step_1
        expect(response).to be_success
      end

      it 'uses no-store header for caching' do
        get :step_1
        expect(response.headers["Cache-Control"]).to eql("no-store")
      end
    end

    describe '#step_2' do
      context "when there is a validation error" do
        render_views

        before :each do
          post :step_2, affordability: {
                          people_attributes: {
                            "0"=>{annual_income: "1", extra_income: "0", monthly_net_income: "1000"}
                          },
                          outgoings: {},
                          lifestyle_costs: "3000"
                        }
        end

        it "redirect to step_1" do
          expect(response.body).to redirect_to(step_1_affordability_path)
        end

        it 'uses no-store header for caching' do
          expect(response.headers["Cache-Control"]).to eql("no-store")
        end
      end
    end

    describe '#step_3' do
      it 'renders the step_3 template' do
        post :step_3, affordability: {
                        people_attributes: {
                          "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "6000"},
                          "1"=>{annual_income: "50000", extra_income: "5000", monthly_net_income: "3000"}
                        },
                        outgoings: {}
                      }

        expect(response).to be_success
        expect(response).to render_template('step_3')
      end

      context "when custom borrowing amount is entered" do
        it 'sets custom house price' do
          post :step_3, affordability: {
                          people_attributes: {
                            "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "6000"},
                            "1"=>{annual_income: "50000", extra_income: "5000", monthly_net_income: "3000"}
                          },
                          outgoings: {},
                          borrowing: "550000"
                        }
          expect(response).to be_success
          expect(assigns(:affordability).borrowing.to_s).to eql("550000")
        end
      end

      context "when custom lifestyle amount is entered" do
        it 'sets custom lifestyle amount' do
          post :step_3, affordability: {
                          people_attributes: {
                            "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "6000"},
                            "1"=>{annual_income: "50000", extra_income: "5000", monthly_net_income: "3000"}
                          },
                          outgoings: {},
                          lifestyle_costs: "3000"
                        }
          expect(response).to be_success
          expect(assigns(:affordability).lifestyle_costs.to_i).to eql(3000)
        end
      end

      describe 'risk' do
        render_views

        context 'when at high risk' do
          it 'renders high risk partial' do
            post :step_3, affordability: {
                            people_attributes: {
                              "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "100"}
                            },
                            outgoings: {}
                          }

            expect(response).to render_template('high_budget_affect')
          end
        end

        context 'when at medium risk' do
          it 'renders medium risk partial' do
            post :step_3, affordability: {
                            people_attributes: {
                              "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "4000"}
                            },
                            outgoings: {}
                          }

            expect(response).to render_template('medium_budget_affect')
          end
        end

        context 'when at low risk' do
          it 'renders low risk partial' do
            post :step_3, affordability: {
                            people_attributes: {
                              "0"=>{annual_income: "100000", extra_income: "10000", monthly_net_income: "8000"}
                            },
                            outgoings: {}
                          }

            expect(response).to render_template('low_budget_affect')
          end
        end
      end
    end

    describe '#next_steps' do
      it 'works' do
        get :next_steps
        expect(response).to be_success
      end
    end
  end
end

