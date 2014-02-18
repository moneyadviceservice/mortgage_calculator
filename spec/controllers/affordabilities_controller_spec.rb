require 'spec_helper'

module MortgageCalculator
  describe AffordabilitiesController do
    describe :show do
      it 'responds with 200' do
        get :show, :locale => 'en'
        response.should be_success
      end
    end
  end
end

