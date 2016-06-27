require 'spec_helper'

describe MortgageCalculator::Repayment do
  subject{ described_class.new price: "120000", deposit: "20000", term_years: "25", interest_rate: "7.5" }

  it_should_behave_like "currency inputs", [:price, :deposit]

  describe 'mortgage attributes' do
    its(:price){ is_expected.to eq 120000 }
    its(:deposit){ is_expected.to eq 20000 }
    its(:debt){ is_expected.to eq 100000 }
    its(:term_years){ is_expected.to eq 25 }
    its(:interest_rate){ is_expected.to eq 7.5 }
  end

  describe 'defaults' do
    subject{ described_class.new }

    its(:price){ is_expected.to be_zero }
    its(:deposit){ is_expected.to be_zero }
    its(:debt){ is_expected.to be_zero }
    its(:term_years){ is_expected.to eq 25 }
    its(:interest_rate){ is_expected.to eq 3 }
  end

  describe 'defaults with empty strings' do
    subject{ described_class.new price: "", deposit: "", term_years: "", interest_rate: "" }

    its(:price){ is_expected.to be_zero }
    its(:deposit){ is_expected.to be_zero }
    its(:debt){ is_expected.to be_zero }
    its(:term_years){ is_expected.to eq 25 }
    its(:interest_rate){ is_expected.to eq 3 }
  end

  describe '#change_interest_rate_by' do
    it 'increases the interest rate' do
      expect(subject.change_interest_rate_by(1).interest_rate).to eq(8.5)
    end

    it 'decreases the interest rate' do
      expect(subject.change_interest_rate_by(-1).interest_rate).to eq(6.5)
    end
  end

  describe 'validations' do
    context 'when price is blank' do
      subject{ described_class.new price: "", deposit: "20000", term_years: "25", interest_rate: "7.5" }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end

    it 'interest rate must be greater than zero' do
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "0"
      expect(subject).not_to be_valid
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "0.01"
      expect(subject).to be_valid
    end

    it 'term years must be greater than zero' do
      subject = described_class.new price: "100000", term_years: "0", interest_rate: "1"
      expect(subject).not_to be_valid
      subject = described_class.new price: "100000", term_years: "25", interest_rate: "1"
      expect(subject).to be_valid
    end
  end

  describe '#monthly_payment' do
    its(:monthly_payment){ is_expected.to be_within(0.01).of(738.99) }
  end

  describe '#total_interest' do
    its(:total_interest){ is_expected.to be_within(1).of(121697) }
  end

  describe '#total_payable' do
    its(:total_payable){ is_expected.to be_within(1).of(221697) }
  end

  describe '#remaining_balances' do
    it 'returns correct remaining balances' do
      balances = subject.remaining_balances

      expect(balances.first).to eq(100000)

      expect(balances[1]).to be_within(1).of(98585)
      expect(balances[10]).to be_within(1).of(79718)
      expect(balances[24]).to be_within(1).of(8518)

      expect(balances.last).to be_within(1).of(0)
    end
  end
end

