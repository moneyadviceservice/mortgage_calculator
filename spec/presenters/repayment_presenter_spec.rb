require 'spec_helper'

module MortgageCalculator
  describe RepaymentPresenter do
    let(:model){ Repayment.new debt: 300000, term_years: 25, interest_rate: 3.5 }
    subject{ described_class.new model }

    describe 'class methods' do
      describe :model_name do
        it 'is the same as repayment model' do
          described_class.model_name.should == MortgageCalculator::Repayment.to_s
        end
      end
    end

    its(:to_key){ subject.to_key.should be_nil }
    its(:persisted?){ subject.persisted?.should be_false }

    its(:debt){ subject.debt.should == "300,000.00" }
    its(:debt){ subject.term_years.should == 25 }
    its(:interest_rate){ subject.interest_rate.should == "3.5" }

    its(:monthly_payment){ subject.monthly_payment.should == "1,501.87" }
    its(:total_interest){ subject.total_interest.should == "150,561.03" }
    its(:total_payable){ subject.total_payable.should == "450,561.03" }
  end
end
