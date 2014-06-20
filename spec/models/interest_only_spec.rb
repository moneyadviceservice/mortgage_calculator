require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new price: "120000", deposit: "20000" }

  describe 'defaults' do
    subject{ described_class.new price: "", deposit: "", term_years: "", interest_rate: "" }

    its(:price){ should be_zero }
    its(:deposit){ should be_zero }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 5 }
  end

  describe 'mortgage attributes' do
    its(:price){ should == 120000 }
    its(:deposit){ should == 20000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 5 }
  end

  describe 'change_interest_rate_by' do
    before :each do
      subject.change_interest_rate_by(1)
    end

    its(:interest_rate){ should == 6 }
  end

  describe 'methods' do
    its(:debt){ should == 100000 }

    it 'has an accurate monthly_payment' do
      expect(subject.monthly_payment.to_f).to eq(416.6666666666667)
    end

    it 'has an accurate total_interest' do
      expect(subject.total_interest.to_f).to eq(125000)
    end

    it 'has an accurate total_payable' do
      expect(subject.total_payable.to_f).to eq(225000.0)
    end
  end

  describe 'with custom inputs' do
    subject{ described_class.new price: "120000", deposit: "20000", term_years: "20", interest_rate: "4" }

    its(:term_years){ should == 20 }
    its(:interest_rate){ should == 4 }
  end
end

