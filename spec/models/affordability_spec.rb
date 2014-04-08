require 'spec_helper'

module MortgageCalculator
  describe Affordability do
    let(:person1){ Person.new({ annual_income: "100000", extra_income: "10000" }) }
    let(:person2){ Person.new({ annual_income: "50000", extra_income: "5000" }) }

    describe 'currency inputs' do
      subject{ described_class.new([person1]) }

      it_should_behave_like "currency inputs", [:monthly_debt]
    end

    describe 'validations' do
      context 'when monthly_debt is text' do
        subject{ described_class.new([person1], 'abc') }

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end

      context 'when a person is not valid' do
        let(:person1){ Person.new({ annual_income: "abc", extra_income: "10000" }) }
        subject{ described_class.new([person1], '0') }

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end

      context 'when it is valid' do
        let(:person1){ Person.new({ annual_income: "100000", extra_income: "" }) }
        let(:person2){ Person.new({ annual_income: "", extra_income: "" }) }
        subject{ described_class.new([person1], '') }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when the user is a sole buyer' do
      subject{ described_class.new([person1], "1000") }

      its(:total_income){ should == 110_000 }
      its(:can_borrow_from){ should == 294_000.00 }
      its(:can_borrow_upto){ should == 392_000.00 }
      its(:number_of_applicants){ should == 1 }
    end

    context 'when there are multiple applicants' do
      subject{ described_class.new([person1, person2], "1000") }

      its(:total_income){ should == 165_000 }
      its(:can_borrow_from){ should == 459_000.00 }
      its(:can_borrow_upto){ should == 612_000.00 }
      its(:number_of_applicants){ should == 2 }
    end
  end
end
