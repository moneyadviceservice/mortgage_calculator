require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new price: "120000", deposit: "20000" }

  describe 'mortgage attributes' do
    its(:price){ should == 120000 }
    its(:deposit){ should == 20000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 5 }
  end

  describe 'methods' do
    its(:debt){ should == 100000 }
    its(:monthly_payment){ subject.monthly_payment.to_f.should == 416.6666666666667 }
    its(:total_interest){ subject.total_interest.to_f.should == 125000 }
    its(:total_payable){ subject.total_payable.to_f.should == 225000.0 }
  end

  describe 'with custom inputs' do
    subject{ described_class.new price: "120000", deposit: "20000", term_years: "20", interest_rate: "4" }

    its(:term_years){ should == 20 }
    its(:interest_rate){ should == 4 }
  end
end

