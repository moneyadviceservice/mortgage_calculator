require 'spec_helper'

describe MortgageCalculator::Person do
  it_should_behave_like "currency inputs", [:annual_income, :extra_income]

  describe 'validations' do
    it 'annual income must be greater than 0' do
      subject.annual_income = 0
      subject.valid?.should be_false

      subject.annual_income = 0.01
      subject.valid?.should be_true
    end
  end
end
