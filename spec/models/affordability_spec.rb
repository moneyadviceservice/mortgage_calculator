require 'spec_helper'

module MortgageCalculator
  describe Affordability do
    let(:person1){ Person.new({ annual_income: 100000, extra_income: 10000 }) }
    let(:person2){ Person.new({ annual_income: 50000, extra_income: 5000 }) }

    describe 'currency inputs' do
      subject{ described_class.new([person1]) }

      it_should_behave_like "currency inputs", [:monthly_debt]
    end

    context 'when the user is a sole buyer' do
      subject{ described_class.new([person1], 1000) }

      its(:total_income){ should == 110_000 }
      its(:can_borrow){ should == 441_000.00 }
      its(:number_of_applicants){ should == 1 }
    end

    context 'when there are multiple applicants' do
      subject{ described_class.new([person1, person2], 1000) }

      its(:total_income){ should == 165_000 }
      its(:can_borrow){ should == 688_500.00 }
      its(:number_of_applicants){ should == 2 }
    end
  end
end
