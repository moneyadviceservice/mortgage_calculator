require 'spec_helper'

describe MortgageCalculator::LandTransactionTax do
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

        its(:tax_due) { is_expected.to eql(175) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.09) }
        its(:total_due) { is_expected.to eql(185_175) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(5725) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3.09) }
        its(:total_due) { is_expected.to eq(190_725) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(3700) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.35) }
        its(:total_due) { is_expected.to eql(278_700) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(11_950) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.35) }
        its(:total_due) { is_expected.to eq(286_950) }
      end
    end

    context 'when house price is 300,000' do
      let(:price) { 300_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(4950) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.65) }
        its(:total_due) { is_expected.to eql(304_950) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(13_950) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.65) }
        its(:total_due) { is_expected.to eq(313_950) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(16_700) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.41) }
        its(:total_due) { is_expected.to eql(506_700) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(31_400) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(6.41) }
        its(:total_due) { is_expected.to eq(521_400) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(18_200) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.57) }
        its(:total_due) { is_expected.to eql(528_200) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(33_500) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(6.57) }
        its(:total_due) { is_expected.to eq(543_500) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(54_950) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(5.86) }
        its(:total_due) { is_expected.to eql(992_450) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(83_075) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(8.86) }
        its(:total_due) { is_expected.to eq(1_020_575) }
      end
    end

    context 'when house price is 2100000' do
      let(:price) { 2_100_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(183_200) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(8.72) }
        its(:total_due) { is_expected.to eql(2_283_200) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(246_200) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(11.72) }
        its(:total_due) { is_expected.to eq(2_346_200) }
      end
    end
  end
end
