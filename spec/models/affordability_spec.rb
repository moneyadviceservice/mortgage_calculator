require 'spec_helper'

describe MortgageCalculator::Affordability do
  context 'when the user is a sole buyer' do
    let(:person1){ MortgageCalculator::Affordability::Person.new({ annual_income: 100000, extra_income: 10000 }) }

    subject{ described_class.new([person1], 1000) }

    its(:total_income){ should == 110000 }
    its(:can_borrow){ should == 441000.00 }
  end

  context 'when there are multiple applicants' do
    let(:person1){ MortgageCalculator::Affordability::Person.new({ annual_income: 100000, extra_income: 10000 }) }
    let(:person2){ MortgageCalculator::Affordability::Person.new({ annual_income: 50000, extra_income: 5000 }) }

    subject{ described_class.new([person1, person2], 1000) }

    its(:total_income){ should == 165000 }
    its(:can_borrow){ should == 688500.00 }
  end
end
