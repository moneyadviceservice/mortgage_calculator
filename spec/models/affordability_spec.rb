require 'spec_helper'

module MortgageCalculator
  describe Affordability do
    let(:person1) do
      Person.new({ annual_income: "100000",
                   extra_income: "10000",
                   monthly_net_income: 6000 })
    end

    let(:person2) do
      Person.new({ annual_income: "50000",
                   extra_income: "5000",
                   monthly_net_income: 3000 })
    end

    describe 'currency inputs' do
      subject{ described_class.new([person1]) }
    end

    describe 'validations' do
      context 'when a person is not valid' do
        let(:person1){ Person.new({ annual_income: "abc", extra_income: "10000" }) }
        subject{ described_class.new([person1]) }

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end

      context 'when it is valid' do
        let(:person1){ Person.new({ annual_income: "100000", extra_income: "" }) }
        let(:person2){ Person.new({ annual_income: "", extra_income: "" }) }
        subject{ described_class.new([person1]) }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when the user is a sole buyer' do
      subject{ described_class.new([person1]) }

      its(:total_income){ should == 110_000 }
      its(:can_borrow_from){ should == 0 }
      its(:can_borrow_upto){ should == 0 }
      its(:number_of_applicants){ should == 1 }
      its(:monthly_net_income){ should == 6000 }
    end

    context 'when there are multiple applicants' do
      subject{ described_class.new([person1, person2]) }

      its(:total_income){ should == 165_000 }
      its(:can_borrow_from){ should == 0 }
      its(:can_borrow_upto){ should == 0 }
      its(:number_of_applicants){ should == 2 }
      its(:monthly_net_income){ should == 9000 }
    end
  end
end
