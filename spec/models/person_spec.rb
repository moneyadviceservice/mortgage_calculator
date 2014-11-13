# encoding: utf-8

require 'spec_helper'

describe MortgageCalculator::Person do
  it_should_behave_like "currency inputs", [:annual_income, :extra_income, :monthly_net_income]

  let(:annual_income) { 55000 }
  let(:extra_income) { 5000 }
  let(:monthly_net_income) { 3000 }

  subject(:person) do
    described_class.new(
      annual_income: annual_income,
      extra_income: extra_income,
      monthly_net_income: monthly_net_income
    )
  end


  describe '#allow_blanks?' do
    it 'returns the value of the allow_blanks property' do
      person = described_class.new({}, false)
      expect(person.allow_blanks?).to eq(false)
      person = described_class.new({}, true)
      expect(person.allow_blanks?).to eq(true)
    end
  end

  describe '#affordablity' do
    let(:affordability) { MortgageCalculator::Affordability.new }

    it 'sets & gets Affordability' do
      subject.affordability = affordability
      expect(subject.affordability).to be affordability
    end
  end

  describe 'validations' do

    context 'when allow_blanks is true' do

      before :each do
        subject.valid?
      end

      context 'when everything is blank' do
        subject { described_class.new({}, true) }
        it { should be_valid }
      end

      context 'when everything is 0' do

        subject {
          described_class.new(
            { annual_income: 0,
            extra_income: 0,
            monthly_net_income: 0},
            true)
        }

        it { should be_valid }
      end

    end

    context 'when allow_blanks is false' do

      it { should validate_numericality_of(:annual_income) }
      it { should validate_numericality_of(:extra_income) }
      it { should validate_numericality_of(:monthly_net_income) }

      context 'when everything is blank' do
        subject{ described_class.new }

        before :each do
          subject.valid?
        end

        it 'adds validation for required fields' do
          expect(subject.errors.messages.values.flatten).to include("Please enter your monthly take-home pay")
        end
      end

      context 'when net monthly income is 0 and annual income is not' do
        let(:annual_income) { 0 }
        let(:extra_income) { 0 }
        let(:monthly_net_income) { 100 }

        it { should_not be_valid }
      end

      describe 'proportional incomes' do
        context 'when monthly net income is too big' do
          let(:annual_income) { 100000 }
          let(:extra_income) { 0 }
          let(:monthly_net_income) { 10000 }

          it { should_not be_valid }
        end

        context 'when incomes are proportional' do
          let(:annual_income) { 100000 }
          let(:extra_income) { 0 }
          let(:monthly_net_income) { 8333.33 }

          it { should be_valid }
        end

        context 'when annual_income is invalid' do
          let(:annual_income) { 'I am invalid!' }
          before { person.valid? }

          it { should_not be_valid }

          it 'should not include a proportional income error' do
            proportional_error_message = I18n.t("affordability.activemodel.errors.mortgage_calculator/person.base.proportional_incomes")

            expect(person.errors[:base]).not_to include(proportional_error_message)
          end
        end
      end
    end
  end

  describe '#total_income' do
    context 'with annual income of £12,000 and extra_income of £5,000' do
      let(:annual_income) { 12_000 }
      let(:extra_income) { 5_000 }

      its(:total_income) { should eq(17_000) }
    end

    context 'with annual income of £12,000 and no extra_income' do
      let(:annual_income) { 12_000 }
      let(:extra_income) { nil }

      its(:total_income) { should eq(12_000) }
    end

    context 'with no annual income, and extra_income of £5,000' do
      let(:annual_income) { nil }
      let(:extra_income) { 5_000 }

      its(:total_income) { should eq(5_000) }
    end

    context 'with invalid annual income, and extra_income of £5,000' do
      let(:annual_income) { 'invalid' }
      let(:extra_income) { 5_000 }

      its(:total_income) { should eq(5_000) }
    end

    context 'with £12,000 annual income, and invalid extra_income' do
      let(:annual_income) { 12_000 }
      let(:extra_income) { 'invalid' }

      its(:total_income) { should eq(12_000) }
    end
  end

end
