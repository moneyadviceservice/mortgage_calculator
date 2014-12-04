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

      its(:tax_due) { should be_zero }
      its(:total_due) { should be_zero }
    end

    context 'when house price is 125000' do
      let(:price) { 125000 }

      its(:tax_due) { should be_zero }
      its(:total_due) { should == 125000 }
    end

    context 'when house price is 185000.00' do
      let(:price) { BigDecimal('185000.00') }

      its(:tax_due) { should == BigDecimal('1200.00') }
      its(:total_due) { should == 186200.00 }
    end

    context 'when house price is 275000' do
      let(:price) { 275000 }

      its(:tax_due) { should == 3750.00 }
      its(:total_due) { should == 278750 }
    end

    context 'when house price is 510000.00' do
      let(:price) { 510000.00 }

      its(:tax_due) { should == 15500.00 }
      its(:total_due) { should == 525500.00 }
    end

    context 'when house price is 937500' do
      let(:price) { 937500 }

      its(:tax_due) { should == 37500 }
      its(:total_due) { should == 975000 }
    end

    context 'when house price is 2100000.00' do
      let(:price) { 2100000.00 }

      its(:tax_due) { should == 165750 }
      its(:total_due) { should == 2265750.00 }
    end
  end
end

