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

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(185_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(5_550) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3) }
        its(:total_due) { is_expected.to eq(190_550) }
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

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(275_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(8_250) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3) }
        its(:total_due) { is_expected.to eq(283_250) }
      end
    end

    context 'when house price is 310,000' do
      let(:price) { 310_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(310_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(310_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(9_300) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
        its(:total_due) { is_expected.to eq(319_300) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(490_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(490_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(14_700) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.0) }
        its(:total_due) { is_expected.to eq(504_700) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.1) }
        its(:total_due) { is_expected.to eql(510_500) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.1) }
        its(:total_due) { is_expected.to eql(510_500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(15_800) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3.10) }
        its(:total_due) { is_expected.to eq(525_800) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(22_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(2.4) }
        its(:total_due) { is_expected.to eql(960_000) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(22_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(2.4) }
        its(:total_due) { is_expected.to eql(960_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(50_625) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(5.4) }
        its(:total_due) { is_expected.to eq(988_125) }
      end
    end

    context 'when house price is 2,100,000' do
      let(:price) { 2_100_000 }

      context 'and is first time buy' do
        let(:buyer_type) { 'isFTB' }

        its(:tax_due) { is_expected.to eql(150_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.18) }
        its(:total_due) { is_expected.to eql(2_250_750) }
      end

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(150_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.18) }
        its(:total_due) { is_expected.to eql(2_250_750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(213_750) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(10.18) }
        its(:total_due) { is_expected.to eq(2_313_750) }
      end
    end

    context 'when house price has result with decimal values' do
      context 'and is not a second home' do
        let(:price) { 300_019 }
        let(:buyer_type) { 'isNextHome' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to be_zero
        end
        its(:total_due) { is_expected.to eql(300_019) }
      end

      context 'and is first time buy' do
        let(:price) { 400_012 }
        let(:buyer_type) { 'isFTB' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to be_zero
        end
        its(:total_due) { is_expected.to eql(400_012) }
      end

      context 'and is a second home' do
        let(:price) { 988_882 }
        let(:buyer_type) { 'isSecondHome' }

        it 'should round down to the nearest GBP' do
          expect(subject.tax_due).to eql(57304)
        end

        its(:total_due) { is_expected.to eq(1_046_186) }
      end
    end
  end
end
