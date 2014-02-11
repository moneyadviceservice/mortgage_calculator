require 'spec_helper'

describe MortgageCalculator::Repayment do
  subject{ described_class.new debt: 100000, term_years: 25, interest_rate: 7.5 }

  describe 'mortgage attributes' do
    its(:debt){ should == 100000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 7.5 }
  end

  describe :monthly_payment do
    its(:monthly_payment){ should be_within(0.01).of(738.99) }
  end

  describe :total_interest do
    its(:total_interest){ should be_within(1).of(121697) }
  end

  describe :total_payable do
    its(:total_payable){ should be_within(1).of(221697) }
  end

  describe :remaining_balances do
    it 'returns correct remaining balances' do
      balances = subject.remaining_balances

      balances.first.should == 100000

      balances[1].should be_within(1).of(98585)
      balances[10].should be_within(1).of(79718)
      balances[24].should be_within(1).of(8518)

      balances.last.should == 0
    end
  end
end

