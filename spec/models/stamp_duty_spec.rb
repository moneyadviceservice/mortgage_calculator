require 'spec_helper'

describe MortgageCalculator::StampDuty do
  describe 'calculations' do
    context 'when house price is 0' do
      subject{ described_class.new(price: 0) }

      it '#percentage_rate returns 0' do
        subject.percentage_rate.should be_zero
      end

      it '#tax_due returns 0' do
        subject.tax_due.should be_zero
      end
    end

    context 'when house price is 125000' do
      subject{ described_class.new(price: 125000) }

      it 'returns 0' do
        subject.percentage_rate.should be_zero
      end

      it '#tax_due returns 0' do
        subject.tax_due.should be_zero
      end
    end

    context 'when house price is 125000.01' do
      subject{ described_class.new(price: 125000.01) }

      it 'returns 1' do
        subject.percentage_rate.should == 1
      end

      it '#tax_due returns 1250.00' do
        subject.tax_due.should == 1250.00
      end
    end

    context 'when house price is 250000' do
      subject{ described_class.new(price: 250000) }

      it 'returns 1' do
        subject.percentage_rate.should == 1
      end

      it '#tax_due returns 2500' do
        subject.tax_due.should == 2500
      end
    end

    context 'when house price is 250000.01' do
      subject{ described_class.new(price: 250000.01) }

      it 'returns 3' do
        subject.percentage_rate.should == 3
      end

      it '#tax_due returns 7500' do
        subject.tax_due.should == 7500
      end
    end

    context 'when house price is 500000' do
      subject{ described_class.new(price: 500000) }

      it 'returns 3' do
        subject.percentage_rate.should == 3
      end

      it '#tax_due returns 15000' do
        subject.tax_due.should == 15000
      end
    end

    context 'when house price is 500000.01' do
      subject{ described_class.new(price: 500000.01) }

      it 'returns 4' do
        subject.percentage_rate.should == 4
      end

      it '#tax_due returns 20000' do
        subject.tax_due.should == 20000
      end
    end

    context 'when house price is 1000000' do
      subject{ described_class.new(price: 1000000) }

      it 'returns 4' do
        subject.percentage_rate.should == 4
      end

      it '#tax_due returns 40000' do
        subject.tax_due.should == 40000
      end
    end

    context 'when house price is 1000000.01' do
      subject{ described_class.new(price: 1000000.01) }

      it 'returns 5' do
        subject.percentage_rate.should == 5
      end

      it '#tax_due returns 50000' do
        subject.tax_due.should == 50000
      end
    end

    context 'when house price is 2000000' do
      subject{ described_class.new(price: 2000000) }

      it 'returns 5' do
        subject.percentage_rate.should == 5
      end

      it '#tax_due returns 100000' do
        subject.tax_due.should == 100000
      end
    end

    context 'when house price is 2000000.01' do
      subject{ described_class.new(price: 2000000.01) }

      it 'returns 7' do
        subject.percentage_rate.should == 7
      end

      it '#tax_due returns 140000' do
        subject.tax_due.should == 140000
      end
    end

    context 'when house price is 3000000' do
      subject{ described_class.new(price: 3000000) }

      it 'returns 7' do
        subject.percentage_rate.should == 7
      end

      it '#tax_due returns 210000' do
        subject.tax_due.should == 210000
      end
    end
  end
end

