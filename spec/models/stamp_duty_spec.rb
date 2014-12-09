require 'spec_helper'

describe MortgageCalculator::StampDuty do
  describe 'default state' do
    it 'sets price to zero' do
      expect(subject.price).to be_zero
    end
  end

  it_should_behave_like "currency inputs", [:price]

  describe 'calculations' do
    subject { described_class.new(price: price)}

    context 'when house price is text' do
      let(:price) { "asd" }

      it 'has errors' do
        subject.valid?
        expect(subject.errors).not_to be_empty
      end
    end

    context 'when house price is 0' do
      let(:price) { 0 }

      its(:tax_due) { is_expected.to be_zero }
      its(:percentage_tax) { is_expected.to be_zero }
      its(:total_due) { is_expected.to be_zero }
    end

    context 'when house price is 125000' do
      let(:price) { 125000 }

      its(:tax_due) { is_expected.to be_zero }
      its(:percentage_tax) { is_expected.to be_zero }
      its(:total_due) { is_expected.to eql(125000) }
    end

    context 'when house price is 185000.00' do
      let(:price) { 185000 }

      its(:tax_due) { is_expected.to eql(1200.00) }
      its(:percentage_tax) { is_expected.to be_within(0.1).of(0.7) }
      its(:total_due) { is_expected.to eql(186200.00) }
    end

    context 'when house price is 275000' do
      let(:price) { 275000 }

      its(:tax_due) { is_expected.to eql(3750.00) }
      its(:percentage_tax) { is_expected.to be_within(0.1).of(1.4) }
      its(:total_due) { is_expected.to eql(278750) }
    end

    context 'when house price is 510000.00' do
      let(:price) { 510000.00 }

      its(:tax_due) { is_expected.to eql(15500.00) }
      its(:percentage_tax) { is_expected.to be_within(0.1).of(3) }
      its(:total_due) { is_expected.to eql(525500.00) }
    end

    context 'when house price is 937500' do
      let(:price) { 937500 }

      its(:tax_due) { is_expected.to eql(37500) }
      its(:percentage_tax) { is_expected.to be_within(0.1).of(4) }
      its(:total_due) { is_expected.to eql(975000) }
    end

    context 'when house price is 2100000.00' do
      let(:price) { 2100000.00 }

      its(:tax_due) { is_expected.to eql(165750) }
      its(:percentage_tax) { is_expected.to be_within(0.1).of(7.9) }
      its(:total_due) { is_expected.to eql(2265750.00) }
    end
  end
end

