require 'spec_helper'

module MortgageCalculator
  describe Affordability do
    let(:person1) do
      Person.new({ annual_income: "100000",
                   extra_income: "10000",
                   monthly_net_income: "6000" })
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
        childcare: 100,
        child_maintenance: 0,
        rent_and_mortgage: 600,
        food: 200,
        travel: 200,
        entertainment: 400
      )
    end

    subject{ described_class.new(people: [person1], outgoings: outgoings) }

    describe 'validations' do
      context 'when it is valid' do
        let(:person1){ Person.new({ annual_income: "100000", extra_income: "", monthly_net_income: "6000" }) }
        let(:person2){ Person.new({ annual_income: "", extra_income: "", monthly_net_income: "" }) }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when a person is not valid' do
        let(:person1){ Person.new({ annual_income: "abc", extra_income: "10000" }) }

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end

      context 'when outgoings is not valid' do
        let(:person1){ Person.new({ annual_income: "10000", extra_income: "10000" }) }
        let(:outgoings) do
          Outgoings.new(
            credit_repayments: "asd",
            utilities: 200,
            childare: 100,
            child_maintenance: 0,
            rent_and_mortgage: 600,
            food: 200,
            travel: 200,
            entertainment: 400
          )
        end

        it 'is not valid' do
          expect(subject).to_not be_valid
        end
      end
    end

    context 'when the user is a sole buyer' do
      its(:total_income){ should == 110_000 }
      its(:can_borrow_from){ should == 301_280 }
      its(:can_borrow_upto){ should == 451_920 }
      its(:number_of_applicants){ should == 1 }
      its(:monthly_net_income){ should == 6000 }
    end

    context 'when there are multiple applicants' do
      subject{ described_class.new(people: [person1, person2], outgoings: outgoings) }

      its(:total_income){ should == 165_000 }
      its(:can_borrow_from){ should == 455_280 }
      its(:can_borrow_upto){ should == 682_920}
      its(:number_of_applicants){ should == 2 }
      its(:monthly_net_income){ should == 9000 }

      it 'sets up relationship with persons' do
        subject.people.each do |person|
          expect(person.affordability).to be subject
        end
      end
    end

    describe '#can_borrow_from' do
      it 'is rounded to nearest pound' do
        allow(subject).to receive(:total_income).and_return(BigDecimal("123000.13"))
        expect(subject.can_borrow_from.to_s).to eql('337680')
      end
    end

    describe '#can_borrow_upto' do
      it 'is rounded to nearest pound' do
        allow(subject).to receive(:total_income).and_return(BigDecimal("123000.13"))
        expect(subject.can_borrow_upto.to_s).to eql('506521')
      end
    end

    describe '#borrowing' do
      context 'when borrowing is not given' do
        subject { described_class.new(people: [person1], outgoings: outgoings) }

        its(:borrowing) { is_expected.to eq(subject.default_borrowing_amount) }
      end

      context 'when borrowing is given' do
        subject { described_class.new(people: [person1], outgoings: outgoings, borrowing: borrowing) }

        context 'and is nil' do
          let(:borrowing) { nil }

          its(:borrowing) { is_expected.to eq(subject.default_borrowing_amount) }
        end

        context 'and is a number' do
          let(:borrowing) { 123 }

          its(:borrowing) { is_expected.to eq(123) }
        end

        context 'and is "0"' do
          let(:borrowing) { '0' }

          its(:borrowing) { is_expected.to eq('0') }
        end

        context 'and is "999"' do
          let(:borrowing) { '999' }

          its(:borrowing) { is_expected.to eq('999') }
        end

        context 'and is "1,000"' do
          let(:borrowing) { '1,000' }

          its(:borrowing) { is_expected.to eq('1000') }
        end

        context 'and is "1.99"' do
          let(:borrowing) { '1.99' }

          its(:borrowing) { is_expected.to eq('1.99') }
        end
      end
    end

    describe '#lifestyle_costs' do
      context 'when overridden' do
        subject{ described_class.new(people: [person1], outgoings: outgoings, lifestyle_costs: 123) }

        it 'uses overridden value' do
          expect(subject.lifestyle_costs.to_i).to eql(123)
        end
      end
    end

    describe '#interest_rate' do
      context 'when not overridden' do
        it 'uses the application default' do
          expected = MortgageCalculator::Defaults::DEFAULT_ANNUAL_INTEREST_RATE
          expect(subject.repayment.interest_rate.to_i).to eql(expected)
        end
      end

      context 'when overridden' do
        subject{ described_class.new(people: [person1], outgoings: outgoings, interest_rate: 13) }

        it 'use new value' do
          expect(subject.repayment.interest_rate.to_i).to eql(13)
        end
      end
    end

    describe '#risk_percentage' do
      it "is (monthly mortgage repayments + commited costs) / take home" do
        expect(subject.risk_percentage.to_i).to eql(41)
      end

      context 'when over 100%' do
        subject{ described_class.new(people: [person1], outgoings: outgoings, interest_rate: 50) }

        it 'is capped at 100%' do
          expect(subject.risk_percentage.to_i).to eql(100)
        end
      end

      context 'when divide by zero' do
        subject{ described_class.new(people: [person1], outgoings: Outgoings.new) }

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

    describe '#inverse_risk_percentage' do
      it 'is the 100 - risk percentage' do
        allow(subject).to receive(:risk_percentage){ 10 }
        expect(subject.inverse_risk_percentage).to eql(90)

        allow(subject).to receive(:risk_percentage){ 50 }
        expect(subject.inverse_risk_percentage).to eql(50)
      end
    end

    describe '#risk_level' do
      context 'when it is under 40' do
        it 'returns :low' do
          allow(subject).to receive(:risk_percentage){ 0 }
          expect(subject.risk_level).to eql(:low)

          allow(subject).to receive(:risk_percentage){ 39 }
          expect(subject.risk_level).to eql(:low)
        end
      end

      context 'when it is between 40 and 60' do
        it 'returns :medium' do
          allow(subject).to receive(:risk_percentage){ 40 }
          expect(subject.risk_level).to eql(:medium)

          allow(subject).to receive(:risk_percentage){ 60 }
          expect(subject.risk_level).to eql(:medium)
        end
      end

      context 'when it is over 60' do
        it 'returns :high' do
          allow(subject).to receive(:risk_percentage){ 61 }
          expect(subject.risk_level).to eql(:high)

          allow(subject).to receive(:risk_percentage){ 100 }
          expect(subject.risk_level).to eql(:high)
        end
      end
    end

    describe '#remaining' do
      it 'returns remaining amount per month' do
        expect(subject.remaining.to_i).to eql(2914)
      end
    end

    describe '#remaining_positive?' do
      context 'when positive' do
        it 'returns true' do
          expect(subject.remaining_positive?).to be_truthy
        end
      end

      context 'when zero' do
        it 'returns true' do
          allow(subject).to receive(:remaining){ BigDecimal.new("0")  }
          expect(subject.remaining_positive?).to be_truthy
        end
      end

      context 'when negative' do
        it 'returns false' do
          allow(subject).to receive(:remaining){ BigDecimal.new("-1")  }
          expect(subject.remaining_positive?).to be_falsey
        end
      end
    end

    describe '#remaining_negative?' do
      context 'when positive' do
        it 'returns false' do
          expect(subject.remaining_negative?).to be_falsey
        end
      end

      context 'when zero' do
        it 'returns false' do
          allow(subject).to receive(:remaining){ BigDecimal.new("0")  }
          expect(subject.remaining_negative?).to be_falsey
        end
      end

      context 'when negative' do
        it 'returns true' do
          allow(subject).to receive(:remaining){ BigDecimal.new("-1")  }
          expect(subject.remaining_negative?).to be_truthy
        end
      end
    end

    describe '#budget_outgoing' do
      it 'returns mortgage repayment + fix + committed costs' do
        expect(subject.budget_outgoing.to_i).to eql(2485)
      end
    end

    describe '#budget_leftover' do
      it 'returns net monthly - budget_outgoing' do
        expect(subject.budget_leftover.to_i).to eql(3514)
      end
    end

    describe '#remaining_vector' do
      context 'when positive' do
        it 'returns positive' do
          expect(subject.remaining_vector).to eql(:positive)
        end
      end

      context 'when negative' do
        it 'returns negative' do
          allow(subject).to receive(:remaining){ BigDecimal.new("-1")  }
          expect(subject.remaining_vector).to eql(:negative)
        end
      end
    end

    describe 'warnings' do
      context 'sum of lifestyle costs is zero' do
        it "missing_lifestyle_costs_warning is true" do
          allow(subject).to receive(:lifestyle_costs){ BigDecimal.new("0") }
          expect(subject.missing_lifestyle_costs_warning?).to be_truthy
        end
      end

      context 'sum of lifestyle costs is not zero' do
        it "missing_lifestyle_costs_warning is false" do
          allow(subject).to receive(:lifestyle_costs){ BigDecimal.new("1") }
          expect(subject.missing_lifestyle_costs_warning?).to be_falsey
        end
      end

      context 'sum of fixed and committed costs is zero' do
        it "missing_fixed_and_committed_costs_warning returns true" do
          allow(subject).to receive(:fixed_costs){ BigDecimal.new("0") }
          allow(subject).to receive(:committed_costs){ BigDecimal.new("0") }
          expect(subject.missing_fixed_and_committed_costs_warning?).to be_truthy
        end
      end

      context 'sum of fixed and committed costs is not zero' do
        it "missing_fixed_and_committed_costs_warning returns false" do
          allow(subject).to receive(:fixed_costs){ BigDecimal.new("1") }
          allow(subject).to receive(:committed_costs){ BigDecimal.new("0") }
          expect(subject.missing_fixed_and_committed_costs_warning?).to be_falsey
        end
      end

      context 'when only rent and mortgage present' do
        subject{ described_class.new(people: [], outgoings: Outgoings.new(rent_and_mortgage: 1)) }

        it "only_rent_and_mortgage_warning returns true" do
          expect(subject.only_rent_and_mortgage_warning?).to be_truthy
        end
      end

      context 'when not only rent and mortgage present' do
        subject{ described_class.new(people: [], outgoings: Outgoings.new(rent_and_mortgage: 1, utilities: 1)) }

        it "only_rent_and_mortgage_warning returns false" do
          expect(subject.only_rent_and_mortgage_warning?).to be_falsey
        end
      end
    end

    let(:serialized_hash) do
      { "people_attributes" => {
          '0' => {'annual_income'=>"100000.0",
                  'extra_income'=>"10000.0",
                  'monthly_net_income'=>"6000.0"},
          '1' => {'annual_income'=>"50000.0",
                  'extra_income'=>"5000.0",
                  'monthly_net_income'=>"3000.0"}},
         "two_applicants" => "1",
         "outgoings" => {
           "child_maintenance"=>"0.00",
           "childcare"=>"100.00",
           "credit_repayments"=>"200.00",
           "entertainment"=>"400.00",
           "food"=>"200.00",
           "holidays"=>"0.00",
           "rent_and_mortgage"=>"600.00",
           "travel"=>"200.00",
           "utilities"=>"200.00"
        }
      }
    end

    describe '#load_from_store' do
      let(:store) do
        { affordability: serialized_hash }
      end

      subject{ described_class.load_from_store(store) }

      it 'loads from store' do
        expect(subject.total_income).to eql(165000)
        expect(subject.two_applicants?).to eql(true)
      end

      context 'when store is empty' do
        let(:store){ Hash.new }

        it 'loads nothing' do
          expect(subject.total_income).to eql(0)
          expect(subject.lifestyle_costs).to eql(0)
        end
      end
    end

    describe 'over_committed?' do
      context 'when committed + fixed costs > monthly_net_income' do
        it 'returns true' do
          allow(subject.outgoings).to receive(:credit_repayments).and_return(20000)
          expect(subject.over_committed?).to be_truthy
        end
      end

      context 'when committed + fixed costs < monthly_net_income' do
        it 'returns false' do
          expect(subject.over_committed?).to be_falsey
        end
      end
    end
  end
end
