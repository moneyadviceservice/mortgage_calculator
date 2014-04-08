require 'spec_helper'

module MortgageCalculator
  describe AffordabilitiesController do
    describe :show do
      it 'responds with 200' do
        get :show, :locale => 'en'
        expect(response).to be_success
      end
    end

    describe :create do
      it 'responds with 200' do
        post :create, locale: 'en',
                      affordability: {people_attributes: {"0"=>{annual_income: "100000", extra_income: "10000"},
                                                          "1"=>{annual_income: "50000", extra_income: "5000"}}, monthly_debt: "1"}
        expect(response).to be_success
      end

      it 'renders the create template' do
        post :create, locale: 'en',
                      affordability: {people_attributes: {"0"=>{annual_income: "100000", extra_income: "10000"},
                                                          "1"=>{annual_income: "50000", extra_income: "5000"}}, monthly_debt: "1"}
        expect(response).to render_template('create')
      end
    end
  end
end

