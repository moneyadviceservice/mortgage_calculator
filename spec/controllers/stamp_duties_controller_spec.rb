require 'spec_helper'

module MortgageCalculator
  describe StampDutiesController do
    routes { MortgageCalculator::Engine.routes }

    describe 'when feature is toggled off' do
      around :each do
        Rails.application.reload_routes!
      end

      it 'the stamp duty calculator is not available' do
        allow(Settings.feature_toggles).to receive(:enable_stamp_duty_calculator?){ false }

        get :show
        expect(response).not_to be_success
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
        post :create, stamp_duty: { price: "200000" }
        expect(response).to be_success
      end

      context 'when price is invalid' do
        render_views

        it 'renders show template' do
          post :create, stamp_duty: { price: "asd" }
          expect(response).to render_template('show')
        end
      end
    end

    describe '#next_steps' do
      it 'works' do
        get :next_steps
      end
    end
  end
end

