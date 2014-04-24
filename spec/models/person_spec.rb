require 'spec_helper'

describe MortgageCalculator::Person do
  it_should_behave_like "currency inputs", [:annual_income, :extra_income, :monthly_net_income]

  describe 'validations' do
    it 'annual income must be a number' do
      subject.annual_income = 'abc'
      expect(subject).to_not be_valid

      subject.annual_income = 0.01
      expect(subject).to be_valid
    end
  end
end
