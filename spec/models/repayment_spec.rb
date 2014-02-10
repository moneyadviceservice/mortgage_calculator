require 'spec_helper'

describe MortgageCalculator::Repayment do
  subject{ described_class.new debt: 100000, term_years: 25, interest_rate: 7.5 }

  describe 'mortgage attributes' do
    it 'are set correctly' do
      subject.debt.should == 100000
      subject.term_years.should == 25
      subject.interest_rate.should == 7.5
    end
  end

  describe :monthly_payment do
    it 'returns 738.99' do
      subject.monthly_payment.should be_within(0.01).of(738.99)
    end
  end

  describe :total_interest do
    it 'returns 121697' do
      subject.total_interest.should be_within(1).of(121697)
    end
  end

  describe :total_payable do
    it 'returns 221697' do
      subject.total_payable.should be_within(1).of(221697)
    end
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

