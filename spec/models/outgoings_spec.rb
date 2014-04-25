require 'spec_helper'

describe MortgageCalculator::Outgoings do
  describe 'attributes' do
    let(:input_hash) do
      {
        credit_repayments: 200,
        utilities: 300,
        childcare: 200,
        child_maintenance: 0,
        rent_and_mortgage: 600,
        food: 200,
        travel: 150,
        entertainment: 150
      }
    end

    subject{ described_class.new(input_hash) }

    it 'is initialised with correct attributes' do
      expect(subject.credit_repayments).to eql(200)
      expect(subject.utilities).to eql(300)
      expect(subject.childcare).to eql(200)
      expect(subject.child_maintenance).to eql(0)
      expect(subject.rent_and_mortgage).to eql(600)
      expect(subject.food).to eql(200)
      expect(subject.travel).to eql(150)
      expect(subject.entertainment).to eql(150)
    end
  end
end
