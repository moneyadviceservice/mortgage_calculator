require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new debt: 100000, term_years: 25, interest_rate: 7.5 }

  describe 'mortgage attributes' do
    it 'are set correctly' do
      subject.debt.should == 100000
      subject.term_years.should == 25
      subject.interest_rate.should == 7.5
    end
  end

  describe :monthly_payment do
    it 'returns 625.00' do
      subject.monthly_payment.should == 625
    end
  end

  describe :total_interest do
    it 'returns 187500' do
      subject.total_interest.should == 187500
    end
  end

  describe :total_payable do
    it 'returns 287500' do
      subject.total_payable.should == 287500
    end
  end
end

