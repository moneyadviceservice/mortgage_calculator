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
  end

  describe 'the range the person can borrow' do
    its(:can_borrow_upto){ should == 252_000 }
    its(:can_borrow_from){ should == 168_000 }
  end
end
