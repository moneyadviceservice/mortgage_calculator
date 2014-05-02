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

    let(:outgoings) do
      Outgoings.new(
        credit_repayments: 200,
        utilities: 200,
        childare: 100,
        child_maintenance: 0,
        rent_and_mortgage: 600,
        food: 200,
        travel: 200,
        entertainment: 400
      )
    end

    subject{ described_class.new([person1], outgoings) }

    describe 'validations' do
      context 'when a person is not valid' do
        let(:person1){ Person.new({ annual_income: "abc", extra_income: "10000" }) }
        subject{ described_class.new([person1], outgoings) }

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end

      context 'when it is valid' do
        let(:person1){ Person.new({ annual_income: "100000", extra_income: "" }) }
        let(:person2){ Person.new({ annual_income: "", extra_income: "" }) }
        subject{ described_class.new([person1], outgoings) }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when the user is a sole buyer' do
      subject{ described_class.new([person1], outgoings) }

      its(:total_income){ should == 110_000 }
      its(:can_borrow_from){ should == 308_000 }
      its(:can_borrow_upto){ should == 462_000 }
      its(:number_of_applicants){ should == 1 }
      its(:monthly_net_income){ should == 6000 }
    end

    context 'when there are multiple applicants' do
      subject{ described_class.new([person1, person2], outgoings) }

      its(:total_income){ should == 165_000 }
      its(:can_borrow_from){ should == 462_000 }
      its(:can_borrow_upto){ should == 693_000 }
      its(:number_of_applicants){ should == 2 }
      its(:monthly_net_income){ should == 9000 }
    end

    describe :borrowing do
      context 'default amount' do
        it 'is half way between the range they can borrow' do
          half = (subject.can_borrow_from + subject.can_borrow_upto) / 2
          expect(subject.borrowing).to eql(half)
        end
      end

      context 'when overriden' do
        subject{ described_class.new([person1], outgoings, borrowing: 123000) }

        it 'uses overriden value' do
          expect(subject.borrowing).to eql(123000)
        end
      end
    end

    describe :lifestyle_costs do
      context 'when overridden' do
        subject{ described_class.new([person1], outgoings, lifestyle_costs: 123) }

        it 'uses overridden value' do
          expect(subject.lifestyle_costs.to_i).to eql(123)
        end
      end
    end

    describe :interest_rate do
      context 'when overridden' do
        subject{ described_class.new([person1], outgoings, interest_rate: 13) }

        it 'use new value' do
          expect(subject.repayment.interest_rate.to_i).to eql(13)
        end
      end
    end

    describe :risk_percentage do
      it "is (monthly mortgage repayments + commited costs) / take home" do
        expect(subject.risk_percentage.to_i).to eql(44)
      end

      context 'when over 100%' do
        subject{ described_class.new([person1], outgoings, interest_rate: 50) }

        it 'is capped at 100%' do
          expect(subject.risk_percentage.to_i).to eql(100)
        end
      end

      context 'when divide by zero' do
        subject{ described_class.new([person1], Outgoings.new) }

        let(:person1) do
          Person.new({ annual_income: "0",
                       extra_income: "0",
                       monthly_net_income: 0 })
        end

        it 'returns 0' do
          expect(subject.risk_percentage.to_i).to eql(0)
        end
      end
    end

    describe :risk_level do
      context 'when it is under 40' do
        it 'returns :low' do
          subject.stub(:risk_percentage){ 0 }
          expect(subject.risk_level).to eql(:low)

          subject.stub(:risk_percentage){ 39 }
          expect(subject.risk_level).to eql(:low)
        end
      end

      context 'when it is between 40 and 60' do
        it 'returns :medium' do
          subject.stub(:risk_percentage){ 40 }
          expect(subject.risk_level).to eql(:medium)

          subject.stub(:risk_percentage){ 60 }
          expect(subject.risk_level).to eql(:medium)
        end
      end

      context 'when it is over 60' do
        it 'returns :high' do
          subject.stub(:risk_percentage){ 61 }
          expect(subject.risk_level).to eql(:high)

          subject.stub(:risk_percentage){ 100 }
          expect(subject.risk_level).to eql(:high)
        end
      end
    end

    describe :remaining do
      it 'returns remaining amount per month' do
        expect(subject.remaining.to_i).to eql(2549)
      end
    end
  end
end
