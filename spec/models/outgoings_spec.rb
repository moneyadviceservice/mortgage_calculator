require 'spec_helper'

describe MortgageCalculator::Outgoings do
  let(:input_hash) do
    {
      credit_repayments: 200,
      utilities: 300,
      childcare: 200,
      child_maintenance: 0,
      rent_and_mortgage: 600,
      food: 200,
      travel: 150,
      entertainment: 150,
      holidays: 150
    }
  end

  subject{ described_class.new(input_hash) }

  describe 'class methods' do
    subject{ described_class }

    its(:i18n_scope){ expect(subject.i18n_scope).to eql("affordability.activemodel") }
  end

  it_should_behave_like "currency inputs", [:credit_repayments, :utilities, :childcare, :child_maintenance, :rent_and_mortgage, :food, :travel, :entertainment, :holidays]

  describe 'attributes' do
    it 'is initialised with correct attributes' do
      expect(subject.credit_repayments).to eql(200)
      expect(subject.utilities).to eql(300)
      expect(subject.childcare).to eql(200)
      expect(subject.child_maintenance).to eql(0)
      expect(subject.rent_and_mortgage).to eql(600)
      expect(subject.food).to eql(200)
      expect(subject.travel).to eql(150)
      expect(subject.entertainment).to eql(150)
      expect(subject.holidays).to eql(150)
    end

    context "when inputs are not provided" do
      let(:input_hash){ {} }

      it "they default to zero" do
        expect(subject.credit_repayments).to eql(0)
        expect(subject.utilities).to eql(0)
        expect(subject.childcare).to eql(0)
        expect(subject.child_maintenance).to eql(0)
        expect(subject.rent_and_mortgage).to eql(0)
        expect(subject.food).to eql(0)
        expect(subject.travel).to eql(0)
        expect(subject.entertainment).to eql(0)
        expect(subject.holidays).to eql(0)
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:credit_repayments) }
    it { is_expected.to validate_numericality_of(:utilities) }
    it { is_expected.to validate_numericality_of(:childcare) }
    it { is_expected.to validate_numericality_of(:child_maintenance) }
    it { is_expected.to validate_numericality_of(:rent_and_mortgage) }
    it { is_expected.to validate_numericality_of(:food) }
    it { is_expected.to validate_numericality_of(:travel) }
    it { is_expected.to validate_numericality_of(:entertainment) }
    it { is_expected.to validate_numericality_of(:holidays) }
  end

  describe 'commited_costs' do
    it "is sum of credit_repayments, child_maintenance" do
      expect(subject.committed_costs).to eql(200 + 0)
    end
  end

  describe 'fixed_costs' do
    it "is sum of childcare, utilities, travel" do
      expect(subject.fixed_costs).to eql(200 + 300 + 150)
    end
  end

  describe 'lifestyle_costs' do
    it "is sum of food, holidays, entertainment" do
      expect(subject.lifestyle_costs).to eql(200 + 150 + 150)
    end
  end
end
