require 'spec_helper'

describe MortgageCalculator::LandAndBuildingsTransactionTax do
  describe 'default state' do
    it 'sets price to zero' do
      expect(subject.price).to be_zero
    end

    it 'sets buyer_type to standard by default' do
      expect(subject.buyer_type).to eq('isNextHome')
    end
  end

  describe '#second_home?' do
    subject { described_class.new(buyer_type: buyer_type) }

    context 'when is next home' do
      let(:buyer_type) { 'isNextHome' }

      it 'is false' do
        expect(subject).not_to be_second_home
      end
    end

    context 'when is second home' do
      let(:buyer_type) { 'isSecondHome' }

      it 'is true' do
        expect(subject).to be_second_home
      end
    end
  end

  it_should_behave_like 'currency inputs', [:price]

  describe 'calculations' do
    let(:buyer_type) { 'isNextHome' }

    subject { described_class.new(price: price, buyer_type: buyer_type) }

    context 'when house price is text' do
      let(:price) { 'asd' }

      it 'has errors' do
        subject.valid?
        expect(subject.errors).not_to be_empty
      end
    end

    context 'when house price is 0' do
      let(:price) { 0 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to be_zero }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to be_zero }
      end
    end

    context 'when house price is 39000' do
      let(:price) { 39_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(39_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(39_000) }
      end
    end

    context 'when house price is 40000' do
      let(:price) { 40_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(40_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(1200) }
        its(:percentage_tax) { is_expected.to eq(3) }
        its(:total_due) { is_expected.to eq(41_200) }
      end
    end

    context 'when house price is 145000' do
      let(:price) { 145_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(145_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(4350) }
        its(:percentage_tax) { is_expected.to eq(3) }
        its(:total_due) { is_expected.to eq(149_350) }
      end
    end

    context 'when house price is 185000.00' do
      let(:price) { 185_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(800) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.43) }
        its(:total_due) { is_expected.to eql(185_800) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(6350) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3.43) }
        its(:total_due) { is_expected.to eq(191_350) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(3350) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.22) }
        its(:total_due) { is_expected.to eql(278_350) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(11_600) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.22) }
        its(:total_due) { is_expected.to eq(286_600) }
      end
    end

    context 'when house price is 300,000' do
      let(:price) { 300_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(4600) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.53) }
        its(:total_due) { is_expected.to eql(304_600) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(13_600) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.53) }
        its(:total_due) { is_expected.to eq(313_600) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(22_350) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.56) }
        its(:total_due) { is_expected.to eql(512_350) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(37_050) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.56) }
        its(:total_due) { is_expected.to eq(527_050) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(24_350) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.77) }
        its(:total_due) { is_expected.to eql(534_350) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(39_650) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(7.77) }
        its(:total_due) { is_expected.to eq(549_650) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(70_850) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.56) }
        its(:total_due) { is_expected.to eql(1_008_350) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(98_975) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(10.56) }
        its(:total_due) { is_expected.to eq(1_036_475) }
      end
    end

    context 'when house price is 2100000' do
      let(:price) { 2_100_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(210_350) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(10.01) }
        its(:total_due) { is_expected.to eql(2_310_350) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(273_350) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(13.02) }
        its(:total_due) { is_expected.to eq(2_373_350) }
      end
    end
  end
end
