require 'spec_helper'

describe MortgageCalculator::Person do
  it_should_behave_like "currency inputs", [:annual_income, :extra_income, :monthly_net_income]

  subject do
    described_class.new annual_income: 55000,
                        extra_income: 5000,
                        monthly_net_income: 3000
  end

  describe 'validations' do
    it 'annual income must be a number' do
      subject.annual_income = 'abc'
      expect(subject).to_not be_valid

      subject.annual_income = 0.01
      expect(subject).to be_valid
    end
  end

  describe 'the range the person can borrow' do
    its(:can_borrow_upto){ should == 240000 }
    its(:can_borrow_from){ should == 180000 }
  end
end
