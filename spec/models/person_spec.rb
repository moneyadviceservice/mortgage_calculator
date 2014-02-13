require 'spec_helper'

describe MortgageCalculator::Person do
  describe 'validations' do
    it { should validate_presence_of(:annual_income) }
  end
end
