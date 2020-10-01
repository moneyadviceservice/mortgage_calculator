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
        its(:total_due) { is_expected.to eq(39000) }
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
        its(:total_due) { is_expected.to eq(41200) }
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
        its(:total_due) { is_expected.to eq(149350) }
      end
    end

    context 'when house price is 185000.00' do
      let(:price) { 185_000 }

      context 'and is next home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eql(185_000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eql(5725) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.094594594594595) }
        its(:total_due) { is_expected.to eql(190725) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(1250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.454545454545455) }
        its(:total_due) { is_expected.to eql(276250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(11950) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.345454545454545) }
        its(:total_due) { is_expected.to eq(286950) }
      end
    end

    context 'when house price is 300,000' do
      let(:price) { 300_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(2500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.833333333333333) }
        its(:total_due) { is_expected.to eql(302500) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(13950) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4.65) }
        its(:total_due) { is_expected.to eq(313950) }
      end
    end

    context 'when house price is 490,000' do
      let(:price) { 490_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(14250) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(2.908163265306122) }
        its(:total_due) { is_expected.to eql(504250) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(31400) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(6.408163265306122) }
        its(:total_due) { is_expected.to eq(521400) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(15750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3.088235294117647) }
        its(:total_due) { is_expected.to eql(525750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(33500) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(6.568627450980392) }
        its(:total_due) { is_expected.to eq(543500) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937_500 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(52500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(5.6) }
        its(:total_due) { is_expected.to eql(990000) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(83075) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(8.861333333333333) }
        its(:total_due) { is_expected.to eq(1020575) }
      end
    end

    context 'when house price is 2100000' do
      let(:price) { 2_100_000 }

      context 'and is not a second home' do
        let(:buyer_type) { 'isNextHome' }

        its(:tax_due) { is_expected.to eql(180750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(8.607142857142857) }
        its(:total_due) { is_expected.to eql(2280750) }
      end

      context 'and is a second home' do
        let(:buyer_type) { 'isSecondHome' }

        its(:tax_due) { is_expected.to eq(246200) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(11.723809523809524) }
        its(:total_due) { is_expected.to eq(2346200) }
      end
    end
  end
end
