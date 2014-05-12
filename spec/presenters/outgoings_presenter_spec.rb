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
  end
end
