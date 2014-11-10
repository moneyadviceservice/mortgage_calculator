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

      its(:percentage_rate) { should be_zero }
      its(:tax_due) { should be_zero }
      its(:total_due) { should be_zero }
    end

    context 'when house price is 125000' do
      let(:price) { 125000 }

      its(:percentage_rate) { should be_zero }
      its(:tax_due) { should be_zero }
      its(:total_due) { should == 125000 }
    end

    context 'when house price is 125000.01' do
      let(:price) { 125000.01 }

      its(:percentage_rate) { should == 1 }
      its(:tax_due) { should == 1250.00 }
      its(:total_due) { should == 126250.01 }
    end

    context 'when house price is 250000' do
      let(:price) { 250000 }

      its(:percentage_rate) { should == 1 }
      its(:tax_due) { should == 2500.00 }
      its(:total_due) { should == 252500 }
    end

    context 'when house price is 250000.01' do
      let(:price) { 250000.01 }

      its(:percentage_rate) { should == 3 }
      its(:tax_due) { should == 7500.00 }
      its(:total_due) { should == 257500.01 }
    end

    context 'when house price is 500000' do
      let(:price) { 500000 }

      its(:percentage_rate) { should == 3 }
      its(:tax_due) { should == 15000 }
      its(:total_due) { should == 515000 }
    end

    context 'when house price is 500000.01' do
      let(:price) { 500000.01 }

      its(:percentage_rate) { should == 4 }
      its(:tax_due) { should == 20000 }
      its(:total_due) { should == 520000.01 }
    end

    context 'when house price is 1000000' do
      let(:price) { 1000000 }

      its(:percentage_rate) { should == 4 }
      its(:tax_due) { should == 40000 }
      its(:total_due) { should == 1040000 }
    end

    context 'when house price is 1000000.01' do
      let(:price) { 1000000.01 }

      its(:percentage_rate) { should == 5 }
      its(:tax_due) { should == 50000 }
      its(:total_due) { should == 1050000.01 }
    end

    context 'when house price is 2000000' do
      let(:price) { 2000000 }

      its(:percentage_rate) { should == 5 }
      its(:tax_due) { should == 100000 }
      its(:total_due) { should == 2100000 }
    end

    context 'when house price is 2000000.01' do
      let(:price) { 2000000.01 }

      its(:percentage_rate) { should == 7 }
      its(:tax_due) { should == 140000 }
      # On upgrading to Ruby 2.1.2 the expected value needs to be specified
      # as a BigDecimal or this lone test fails.
      its(:total_due) { should == BigDecimal('2140000.01') }
    end

    context 'when house price is 3000000' do
      let(:price) { 3000000 }

      its(:percentage_rate) { should == 7 }
      its(:tax_due) { should == 210000 }
      its(:total_due) { should == 3210000 }
    end
  end
end

