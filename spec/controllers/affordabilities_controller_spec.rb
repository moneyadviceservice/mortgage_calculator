require 'spec_helper'

module MortgageCalculator
  describe AffordabilitiesController do
    routes { MortgageCalculator::Engine.routes }

    describe '#step_1' do
      it 'responds with 200' do
        get :step_1
        expect(response).to be_success
      end

      it 'uses no-store header for caching' do
        get :step_1
        expect(response.headers["Cache-Control"]).to eql("no-store")
      end

      it "persists and loads persisted data from the session" do
        post :step_1, affordability: { cat: 'meow' }
        get :step_1
        expect(session[:affordability]['cat']).to eq('meow')
      end
    end

    describe '#step_2' do
      it 'uses no-store header for caching' do
        get :step_2
        expect(response.headers["Cache-Control"]).to eql("no-store")
      end

      it "persists and loads persisted data from the session" do
        post :step_2, affordability: { cat: 'meow' }
        get :step_2
        expect(session[:affordability]['cat']).to eq('meow')
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

            expect(response).to render_template('_high_budget_affect')
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

            expect(response).to render_template('_medium_budget_affect')
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

            expect(response).to render_template('_low_budget_affect')
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

