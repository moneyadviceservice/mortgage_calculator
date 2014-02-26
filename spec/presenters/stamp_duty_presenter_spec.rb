require 'spec_helper'

module MortgageCalculator
  describe StampDutyPresenter do
    let(:model){ StampDuty.new :price => 300000 }
    subject{ described_class.new model }

    describe 'class methods' do
      describe :model_name do
        it 'is the same as stamp duty model' do
          described_class.model_name.should == MortgageCalculator::StampDuty.to_s
        end
      end
    end

    its(:price){ subject.price.should == "300,000.00" }
    its(:percentage_rate){ subject.percentage_rate.should == 3 }
    its(:tax_due){ subject.tax_due.should == "9,000.00" }
    its(:total_due){ subject.total_due.should == "309,000.00" }

    its(:to_key){ subject.to_key.should be_nil }

    context 'when price is text' do
      let(:model){ StampDuty.new :price => 'abc' }

      it 'returns original input' do
        subject.price.should == "abc"
      end
    end
  end
end
