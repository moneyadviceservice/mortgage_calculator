require 'spec_helper'

describe MortgageCalculator::RepaymentsController do
  routes { MortgageCalculator::Engine.routes }

  describe '#show' do
    it 'responds with 200' do
      get :show, :locale => :en
      expect(response).to be_success
    end
  end

  describe 'cr#eate' do
    it 'responds with 200' do
      post :create, locale: :en, repayment: { price: 60000, term_years: 10, interest_rate: 3.5 }
      expect(response).to be_success
    end

    context 'when invalid input' do
      render_views

      it 'responds renders show template' do
        post :create, locale: :en, repayment: { price: "", term_years: 10, interest_rate: 3.5 }
        expect(response).to render_template('show')
      end

      it 'responds renders show template' do
        post :create, locale: :en, repayment: { price: "asd", deposit: "zxc" }
        expect(response).to render_template('show')
      end
    end
  end

  describe 'next_s#teps' do
    it 'works' do
      get :next_steps, locale: :en
      expect(response).to be_success
    end
  end
end
