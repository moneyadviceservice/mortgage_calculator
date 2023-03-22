require 'spec_helper'

describe MortgageCalculator::InterestOnly do
  subject{ described_class.new price: "120000", deposit: "20000" }

  describe 'defaults' do
    subject{ described_class.new price: "", deposit: "", term_years: "", interest_rate: "" }

    its(:price){ is_expected.to be_zero }
    its(:deposit){ is_expected.to be_zero }
    its(:term_years){ is_expected.to eq 25 }
    its(:interest_rate){ is_expected.to eq 6 }
  end

  describe 'mortgage attributes' do
    its(:price){ is_expected.to eq 120000 }
    its(:deposit){ is_expected.to eq 20000 }
    its(:term_years){ is_expected.to eq 25 }
    its(:interest_rate){ is_expected.to eq 6 }
  end

  describe 'change_interest_rate_by' do
    before{ subject.change_interest_rate_by(1) }

    its(:interest_rate){ is_expected.to eq 7 }
  end

  describe 'with custom inputs' do
    subject{ described_class.new price: "120000", deposit: "20000", term_years: "20", interest_rate: "4" }

    its(:term_years){ is_expected.to eq 20 }
    its(:interest_rate){ is_expected.to eq 4 }
  end

  context 'methods' do
    its(:debt){ is_expected.to eq 100000 }
    its(:monthly_payment){ is_expected.to eq 500 }
    its(:total_interest){ is_expected.to eq 150000 }
    its(:total_payable){ is_expected.to eq 250000 }
  end
end
