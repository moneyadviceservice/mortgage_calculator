require 'spec_helper'

module MortgageCalculator
  describe OutgoingsPresenter do
    subject{ described_class.new model }

    let(:model) do
      Outgoings.new
    end

    its(:to_key){ should be_nil }
    its(:persisted?){ should be_false }

    its(:credit_repayments_formatted){ expect(subject.credit_repayments_formatted).to eql("0.00") }
    its(:utilities_formatted){ expect(subject.utilities_formatted).to eql("0.00") }
    its(:childcare_formatted){ expect(subject.childcare_formatted).to eql("0.00") }
    its(:child_maintenance_formatted){ expect(subject.child_maintenance_formatted).to eql("0.00") }
    its(:rent_and_mortgage_formatted){ expect(subject.rent_and_mortgage_formatted).to eql("0.00") }
    its(:food_formatted){ expect(subject.food_formatted).to eql("0.00") }
    its(:travel_formatted){ expect(subject.travel_formatted).to eql("0.00") }
    its(:entertainment_formatted){ expect(subject.entertainment_formatted).to eql("0.00") }

    describe 'class methods' do
      subject{ described_class }

      its(:model_name){ should == "MortgageCalculator::Outgoings" }
    end

    describe :serializable_hash do
      it 'returns correct hash' do
        expect(subject.serializable_hash).to eql({
          "child_maintenance" => "0.00",
          "childcare" => "0.00",
          "credit_repayments" => "0.00",
          "entertainment" => "0.00",
          "food" => "0.00",
          "rent_and_mortgage" => "0.00",
          "travel" => "0.00",
          "utilities" => "0.00"
        })
      end
    end
  end
end
