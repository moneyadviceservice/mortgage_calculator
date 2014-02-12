require 'spec_helper'

describe MortgageCalculator::Affordability do
  context 'when the user is a sole buyer' do
    subject{ described_class.new(annual_income: 100000,
                                 extra_income: 10000,
                                 monthly_debt: 1000) }

    its(:total_income){ should == 110000 }
    its(:can_borrow){ should == 441000.00 }
  end
end
