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
        expect(subject.valid?).to be_false
      end
    end

    context 'when net monthly income is 0 and annual income is not' do
      subject{ described_class.new(annual_income: 0, extra_income: 0, monthly_net_income: 100) }

      it "is not valid" do
        expect(subject.valid?).to be_false
      end
    end

    describe 'proportional incomes' do
      context 'when monthly net income is too big' do
        subject{ described_class.new(annual_income: 100000, extra_income: 0, monthly_net_income: 10000) }

        it 'is not valid' do
          expect(subject.valid?).to be_false
        end
      end

      context 'when incomes are proportional' do
        subject{ described_class.new(annual_income: 100000, extra_income: 0, monthly_net_income: 8333.33) }

        it 'is valid' do
          expect(subject.valid?).to be_true
        end
      end
    end
  end
end
