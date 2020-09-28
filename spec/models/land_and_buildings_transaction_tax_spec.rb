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

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to be_zero }
      end

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

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(39_000) }
      end

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

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(40_000) }
      end

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(40_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(1600) }
        its(:percentage_tax) { is_expected.to eq(4.0) }
        its(:total_due) { is_expected.to eq(41_600) }
      end
    end

    context 'when house price is 145000' do
      let(:price) { 145_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(145_000) }
      end

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(145_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(5800) }
        its(:percentage_tax) { is_expected.to eq(4) }
        its(:total_due) { is_expected.to eq(150_800) }
      end
    end

    context 'when house price is 185000.00' do
      let(:price) { 185_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(185_000) }
      end

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(185_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(7_400) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4) }
        its(:total_due) { is_expected.to eq(192_400) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(1250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.454545454545455) }
        its(:total_due) { is_expected.to eql(276250) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(1250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.454545454545455) }
        its(:total_due) { is_expected.to eql(276250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(12250) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.454545454545455) }
        its(:total_due) { is_expected.to eq(287250) }
      end
    end

    context 'when house price is 300,000' do
      let(:price) { 300_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(2500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.833333333333333) }
        its(:total_due) { is_expected.to eql(302500) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(2500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.833333333333333) }
        its(:total_due) { is_expected.to eql(302500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(14_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.833333333333333) }
        its(:total_due) { is_expected.to eq(314_500) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(20250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.13265306122449) }
        its(:total_due) { is_expected.to eql(510250) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(20250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.13265306122449) }
        its(:total_due) { is_expected.to eql(510250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(39_850) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(8.13265306122449) }
        its(:total_due) { is_expected.to eq(529_850) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(22250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.362745098039216) }
        its(:total_due) { is_expected.to eql(532250) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(22250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.362745098039216) }
        its(:total_due) { is_expected.to eql(532250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(42650) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(8.362745098039216) }
        its(:total_due) { is_expected.to eq(552650) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(68750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.333333333333333) }
        its(:total_due) { is_expected.to eql(1006250) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(68750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.333333333333333) }
        its(:total_due) { is_expected.to eql(1006250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(106_250) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(11.333333333333333) }
        its(:total_due) { is_expected.to eq(1_043_750) }
      end
    end

    context 'when house price is 2100000' do
      let(:price) { 2_100_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(208250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(9.916666666666667) }
        its(:total_due) { is_expected.to eql(2308250) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(208250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(9.916666666666667) }
        its(:total_due) { is_expected.to eql(2308250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(292_250) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(13.916666666666667) }
        its(:total_due) { is_expected.to eq(2_392_250) }
      end
    end
  end
end
