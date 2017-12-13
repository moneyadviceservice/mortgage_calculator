require 'spec_helper'

describe MortgageCalculator::StampDuty do
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

    context 'when "false" is given' do
      let(:buyer_type) { 'isFTB' }

      it 'is false' do
        expect(subject.send(:second_home?)).to be_falsy
      end
    end

    context 'when "true" is given' do
      let(:buyer_type) { 'isSecondHome' }

      it 'is true' do
        expect(subject.send(:second_home?)).to be_truthy
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

      context 'and is not a second home' do
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

    context 'when house price is 125000' do
      let(:price) { 125_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(125_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(125_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(3750) }
        its(:percentage_tax) { is_expected.to eq(3) }
        its(:total_due) { is_expected.to eq(128_750) }
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

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(1200) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.7) }
        its(:total_due) { is_expected.to eql(186_200) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(6750) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3.65) }
        its(:total_due) { is_expected.to eq(191_750) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(275_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(3750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.4) }
        its(:total_due) { is_expected.to eql(278_750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(12_000) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.36) }
        its(:total_due) { is_expected.to eq(287_000) }
      end
    end

    context 'when house price is 310,000' do
      let(:price) { 310_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.2) }
        its(:total_due) { is_expected.to eql(310_500) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(5500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.8) }
        its(:total_due) { is_expected.to eql(315_500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(14_800) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.8) }
        its(:total_due) { is_expected.to eq(324_800) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(9500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.9) }
        its(:total_due) { is_expected.to eql(499_500) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(14_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
        its(:total_due) { is_expected.to eql(504_500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(29_200) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(6.0) }
        its(:total_due) { is_expected.to eq(519_200) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(15_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
        its(:total_due) { is_expected.to eql(525_500) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(15_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
        its(:total_due) { is_expected.to eql(525_500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(30_800) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(6.04) }
        its(:total_due) { is_expected.to eq(540_800) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(37_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4) }
        its(:total_due) { is_expected.to eql(975_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(37_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4) }
        its(:total_due) { is_expected.to eql(975_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(65_625) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(7.00) }
        its(:total_due) { is_expected.to eq(1_003_125) }
      end
    end

    context 'when house price is 2100000' do
      let(:price) { 2_100_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(165_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.9) }
        its(:total_due) { is_expected.to eql(2_265_750) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(165_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.9) }
        its(:total_due) { is_expected.to eql(2_265_750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(228_750) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(10.89) }
        its(:total_due) { is_expected.to eq(2_328_750) }
      end
    end

    context 'when house price is not easily divisible' do
      context 'and is not a second home' do
        let(:price) { 300_019 }
        let(:buyer_type) { 'isNextHome' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to eql(5000)
        end
        its(:total_due) { is_expected.to eql(305_019) }
      end

      context 'and is first time buy' do
        let(:price) { 400_012 }
        let(:buyer_type) { 'isFTB' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to eql(5000)
        end
        its(:total_due) { is_expected.to eql(405_012) }
      end

      context 'and is a second home' do
        let(:price) { 988_882 }
        let(:buyer_type) { 'isSecondHome' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to eql(72304)
        end
        its(:total_due) { is_expected.to eq(1_061_186) }
      end
    end
  end
end
