require 'spec_helper'

describe MortgageCalculator::StampDuty do
  describe 'default state' do
    it 'sets price to zero' do
      expect(subject.price).to be_zero
    end

    it 'sets second_home to false' do
      expect(subject.second_home).to be_falsy
    end
  end

  describe '#second_home' do
    subject { described_class.new(second_home: checkbox_value) }

    context 'when "false" is given' do
      let(:checkbox_value) { "false" }

      it 'is false' do
        expect(subject.second_home).to be_falsy
      end
    end

    context 'when "true" is given' do
      let(:checkbox_value) { "true" }

      it 'is true' do
        expect(subject.second_home).to be_truthy
      end
    end
  end

  it_should_behave_like "currency inputs", [:price]

  describe 'calculations' do
    let(:second_home) { 'false' }

    subject { described_class.new(price: price, second_home: second_home)}

    context 'when house price is text' do
      let(:price) { "asd" }

      it 'has errors' do
        subject.valid?
        expect(subject.errors).not_to be_empty
      end
    end

    context 'when house price is 0' do
      let(:price) { 0 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to be_zero }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to be_zero }
      end
    end

    context 'when house price is 40000' do
      let(:price) { 40000 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(40000) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(1200) }
        its(:percentage_tax) { is_expected.to eq(3) }
        its(:total_due) { is_expected.to eq(41200) }
      end
    end

    context 'when house price is 125000' do
      let(:price) { 125000 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to be_zero }
        its(:percentage_tax) { is_expected.to be_zero }
        its(:total_due) { is_expected.to eq(125000) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(3750) }
        its(:percentage_tax) { is_expected.to eq(3) }
        its(:total_due) { is_expected.to eq(128750) }
      end
    end

    context 'when house price is 185000.00' do
      let(:price) { 185000 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to eql(1200.00) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(0.7) }
        its(:total_due) { is_expected.to eql(186200.00) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(6750) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(3.65) }
        its(:total_due) { is_expected.to eq(191750) }
      end
    end

    context 'when house price is 275000' do
      let(:price) { 275000 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to eql(3750.00) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(1.4) }
        its(:total_due) { is_expected.to eql(278750) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(12000) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(4.36) }
        its(:total_due) { is_expected.to eq(287000) }
      end
    end

    context 'when house price is 510000.00' do
      let(:price) { 510000.00 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to eql(15500.00) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
        its(:total_due) { is_expected.to eql(525500.00) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(30800) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(6.04) }
        its(:total_due) { is_expected.to eq(540800) }
      end
    end

    context 'when house price is 937500' do
      let(:price) { 937500 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to eql(37500) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(4) }
        its(:total_due) { is_expected.to eql(975000) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(65625) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(7.00) }
        its(:total_due) { is_expected.to eq(1003125) }
      end
    end

    context 'when house price is 2100000.00' do
      let(:price) { 2100000.00 }

      context 'and is not a second home' do
        let(:second_home) { 'false' }

        its(:tax_due) { is_expected.to eql(165750) }
        its(:percentage_tax) { is_expected.to be_within(0.1).of(7.9) }
        its(:total_due) { is_expected.to eql(2265750.00) }
      end

      context 'and is a second home' do
        let(:second_home) { 'true' }

        its(:tax_due) { is_expected.to eq(228750) }
        its(:percentage_tax) { is_expected.to be_within(0.01).of(10.89) }
        its(:total_due) { is_expected.to eq(2328750) }
      end
    end
  end
end
