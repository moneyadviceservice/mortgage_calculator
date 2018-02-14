require 'spec_helper'

RSpec.describe MortgageCalculator::AffordabilitiesController, type: :routing do
  routes { MortgageCalculator::Engine.routes }

  describe 'GET /mortgage-affordability-calculator/step-1' do
    it 'routes to first step in English' do
      expect(get: '/mortgage-affordability-calculator/step-1').to route_to(
        controller: 'mortgage_calculator/affordabilities',
        action: 'step_1'
      )
    end
  end

  describe 'GET /cyfrifiannell-fforddiadwyedd-morgais/step-1' do
    it 'routes to first step in Welsh' do
      expect(get: '/cyfrifiannell-fforddiadwyedd-morgais/step-1').to route_to(
        controller: 'mortgage_calculator/affordabilities',
        action: 'step_1'
      )
    end
  end

  describe 'POST /mortgage-affordability-calculator/step-1' do
    it 'routes to first step in English' do
      expect(post: '/mortgage-affordability-calculator/step-1').to route_to(
        controller: 'mortgage_calculator/affordabilities',
        action: 'step_1'
      )
    end
  end

  describe 'POST /cyfrifiannell-fforddiadwyedd-morgais/step-1' do
    it 'routes to first step in Welsh' do
      expect(post: '/cyfrifiannell-fforddiadwyedd-morgais/step-1').to route_to(
        controller: 'mortgage_calculator/affordabilities',
        action: 'step_1'
      )
    end
  end
end
