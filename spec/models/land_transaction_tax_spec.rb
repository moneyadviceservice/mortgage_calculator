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

    context 'when house price is 39,000' do
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

    context 'when house price is 40,000' do
      let(:price) { 40_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(40_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(1_600) }
        its(:percentage_tax) { is_expected.to eq(4) }
        its(:total_due) { is_expected.to eq(41_600) }
      end
    end

    context 'when house price is 145,000' do
      let(:price) { 145_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(145_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(5_800) }
        its(:percentage_tax) { is_expected.to eq(4) }
        its(:total_due) { is_expected.to eq(150_800) }
      end
    end

    context 'when house price is 185,000' do
      let(:price) { 185_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(185_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eql(7_575) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.094594594594595) }
        its(:total_due) { is_expected.to eql(192_575) }
      end
    end

    context 'when house price is 275,000' do
      let(:price) { 275_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(1_250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.454545454545455) }
        its(:total_due) { is_expected.to eql(276_250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(14_700) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(5.345454545454545) }
        its(:total_due) { is_expected.to eq(289_700) }
      end
    end

    context 'when house price is 300,000' do
      let(:price) { 300_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(2_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.833333333333333) }
        its(:total_due) { is_expected.to eql(302_500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(16_950) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(5.65) }
        its(:total_due) { is_expected.to eq(316_950) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(14_250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(2.908163265306122) }
        its(:total_due) { is_expected.to eql(504_250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(36_300) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.408163265306122) }
        its(:total_due) { is_expected.to eq(526_300) }
      end
    end

    context 'when house price is 510,000' do
      let(:price) { 510_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(15_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.088235294117647) }
        its(:total_due) { is_expected.to eql(525_750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(38_600) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(7.568627450980392) }
        its(:total_due) { is_expected.to eq(548_600) }
      end
    end

    context 'when house price is 937,500' do
      let(:price) { 937_500 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(52_500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(5.6) }
        its(:total_due) { is_expected.to eql(990_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(92_450) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(9.861333333333333) }
        its(:total_due) { is_expected.to eq(1_029_950) }
      end
    end

    context 'when house price is 2,100,000' do
      let(:price) { 2_100_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(180_750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(8.607142857142857) }
        its(:total_due) { is_expected.to eql(2_280_750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(267_200) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(12.723809523809524) }
        its(:total_due) { is_expected.to eq(2_367_200) }
      end
    end
  end
end
