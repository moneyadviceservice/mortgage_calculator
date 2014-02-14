require 'spec_helper'

module MortgageCalculator
  describe StampDutiesController do
    describe :show do
      it 'works' do
        get :show, :locale => 'en'
        response.should be_success
      end
    end
  end
end

