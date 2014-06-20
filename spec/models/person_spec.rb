# encoding: utf-8

require 'spec_helper'

describe MortgageCalculator::Person do
  it_should_behave_like "currency inputs", [:annual_income, :extra_income, :monthly_net_income]

  subject do
    described_class.new annual_income: 55000,
                        extra_income: 5000,
                        monthly_net_income: 3000
  end

  describe 'validations' do
    it { should validate_numericality_of(:annual_income) }
    it { should validate_numericality_of(:extra_income) }
    it { should validate_numericality_of(:monthly_net_income) }

    context 'when annual income is 0 and monthly net income is not' do
      subject{ described_class.new(annual_income: 100, extra_income: 0, monthly_net_income: 0) }

      it "is not valid" do
        expect(subject.valid?).to be_falsey
      end
    end

    context 'when net monthly income is 0 and annual income is not' do
      subject{ described_class.new(annual_income: 0, extra_income: 0, monthly_net_income: 100) }

      it "is not valid" do
        expect(subject.valid?).to be_falsey
      end
    end

    describe 'proportional incomes' do
      context 'when monthly net income is too big' do
        subject{ described_class.new(annual_income: 100000, extra_income: 0, monthly_net_income: 10000) }

        it 'is not valid' do
          expect(subject.valid?).to be_falsey
        end
      end

      context 'when incomes are proportional' do
        subject{ described_class.new(annual_income: 100000, extra_income: 0, monthly_net_income: 8333.33) }

        it 'is valid' do
          expect(subject.valid?).to be_truthy
        end
      end
    end
  end

  describe '#total_income' do
    subject do
      described_class.new(
        annual_income: annual_income,
        extra_income: extra_income
      )
    end

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
