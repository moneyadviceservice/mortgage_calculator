require 'spec_helper'

describe MortgageCalculator::RepaymentsController do
  describe :show do
    it 'responds with 200' do
      get :show, :locale => :en
      response.should be_success
    end
  end

  describe :create do
    it 'responds with 200' do
      post :create, locale: :en, repayment: { price: 60000, term_years: 10, interest_rate: 3.5 }
      response.should be_success
    end

    context 'when invalid input' do
      it 'responds renders show template' do
        post :create, locale: :en, repayment: { price: "", term_years: 10, interest_rate: 3.5 }
        response.should render_template('show')
      end
    end
  end
end
