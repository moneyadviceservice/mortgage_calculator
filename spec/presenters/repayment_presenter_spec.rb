require 'spec_helper'

module MortgageCalculator
  describe RepaymentPresenter do
    let(:model){ Repayment.new price: 320000, deposit: 20000, term_years: 25, interest_rate: 3.5 }
    subject{ described_class.new model }

    describe 'class methods' do
      describe :model_name do
        it 'is the same as repayment model' do
          expect(described_class.model_name).to eq(MortgageCalculator::Repayment.to_s)
        end
      end
    end

    its(:to_key){ expect(subject.to_key).to be_nil }
    its(:persisted?){ expect(subject.persisted?).to be_false }

    its(:price){ should == "320,000.00" }
    its(:deposit){ should == "20,000.00" }
    its(:debt){ should == "300,000.00" }
    its(:term_years){ should == 25 }
    its(:interest_rate){ should == 3.5 }

    its(:monthly_payment){ should == "1,501.87" }
    its(:total_interest){ should == "150,561.03" }
    its(:total_payable){ should == "450,561.03" }
  end
end
