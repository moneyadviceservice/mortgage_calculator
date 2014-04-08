require 'spec_helper'

module MortgageCalculator
  describe AffordabilityPresenter do
    let(:model){ Affordability.new([Person.new]) }
    subject{ described_class.new model }

    its(:to_key){ should be_nil }
    its(:persisted?){ should be_false }
    its(:monthly_debt){ should == "0.00" }
    its(:people_attributes=){ expect(subject.people_attributes = ('test')).not_to be_nil }

    describe 'class methods' do
      subject{ described_class }

      its(:model_name){ should == "MortgageCalculator::Affordability" }
    end
  end
end
