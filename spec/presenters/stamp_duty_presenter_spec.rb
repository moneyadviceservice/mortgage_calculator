require 'spec_helper'

module MortgageCalculator
  describe StampDutyPresenter do
    let(:model){ StampDuty.new :price => 300000 }
    subject{ described_class.new model }

    describe 'class methods' do
      describe :model_name do
        it 'is the same as stamp duty model' do
          expect(described_class.model_name).to eq(MortgageCalculator::StampDuty.to_s)
        end
      end
    end

    its(:price){ expect(subject.price).to eq("300,000.00") }
    its(:percentage_rate){ expect(subject.percentage_rate).to eq(3) }
    its(:tax_due){ expect(subject.tax_due).to eq("9,000.00") }
    its(:total_due){ expect(subject.total_due).to eq("309,000.00") }

    its(:to_key){ expect(subject.to_key).to be_nil }
  end
end
