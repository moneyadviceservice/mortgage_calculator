require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new price: "120000", deposit: "20000" }

  describe 'defaults' do
    subject{ described_class.new price: "", deposit: "", term_years: "", interest_rate: "" }

    its(:price){ should be_zero }
    its(:deposit){ should be_zero }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 3 }
  end

  describe 'mortgage attributes' do
    its(:price){ should == 120000 }
    its(:deposit){ should == 20000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 3 }
  end

  describe 'change_interest_rate_by' do
    before :each do
      subject.change_interest_rate_by(1)
    end

    its(:interest_rate){ should == 4 }
  end

  describe 'with custom inputs' do
    subject{ described_class.new price: "120000", deposit: "20000", term_years: "20", interest_rate: "4" }

    its(:term_years){ should == 20 }
    its(:interest_rate){ should == 4 }
  end

  context 'methods' do
    its(:debt){ should == 100000 }
    its(:monthly_payment){ should == 250 }
    its(:total_interest){ should == 75000 }
    its(:total_payable){ should == 175000 }
  end
end
