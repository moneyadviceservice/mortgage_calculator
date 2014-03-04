require 'spec_helper'

describe MortgageCalculator::Repayment do
  subject{ described_class.new price: "120000", deposit: "20000", term_years: "25", interest_rate: "7.5" }

  it_should_behave_like "currency inputs", [:price, :deposit]

  describe 'mortgage attributes' do
    its(:price){ should == 120000 }
    its(:deposit){ should == 20000 }
    its(:debt){ should == 100000 }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 7.5 }
  end

  describe 'defaults' do
    subject{ described_class.new }

    its(:price){ should be_zero }
    its(:deposit){ should be_zero }
    its(:debt){ should be_zero }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 5 }
  end

  describe 'validations' do
    context 'when price is blank' do
      subject{ described_class.new price: "", deposit: "20000", term_years: "25", interest_rate: "7.5" }

      it 'is not valid' do
        subject.should_not be_valid
      end
    end

    context 'when term years is blank' do
      subject{ described_class.new price: "100000", term_years: "", interest_rate: "7.5" }

      it 'is not valid' do
        subject.should_not be_valid
      end
    end

    context 'when interest rate is blank' do
      subject{ described_class.new price: "100000", term_years: "25", interest_rate: "" }

      it 'is not valid' do
        subject.should_not be_valid
      end
    end

    it 'interest rate must be greater than zero' do
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "0"
      subject.should_not be_valid
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "0.01"
      subject.should be_valid
    end

    it 'term years must be greater than zero' do
      subject = described_class.new price: "100000", term_years: "0", interest_rate: "1"
      subject.should_not be_valid
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "1"
      subject.should be_valid
    end
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

      balances.last.should be_within(1).of(0)
    end
  end
end

