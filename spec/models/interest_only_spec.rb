require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new debt: 100000, term_years: 25, interest_rate: 7.5 }

  describe 'mortgage attributes' do
    its(:debt){ should == 100000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 7.5 }
  end

  describe 'methods' do
    its(:monthly_payment){ should == 625 }
    its(:total_interest){ should == 187500 }
    its(:total_payable){ should == 287500 }
  end
end

