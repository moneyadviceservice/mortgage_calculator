require 'spec_helper'

module MortgageCalculator
  describe AffordabilityPresenter do
    let(:outgoings){ Outgoings.new }
    let(:model){ Affordability.new([Person.new], outgoings) }
    subject{ described_class.new model }

    its(:to_key){ should be_nil }
    its(:persisted?){ should be_false }
    its(:people_attributes=){ expect(subject.people_attributes = ('test')).not_to be_nil }
    its(:outgoings){ expect(subject.outgoings).to eql(outgoings) }

    describe 'class methods' do
      subject{ described_class }

      its(:model_name){ should == "MortgageCalculator::Affordability" }
      its(:i18n_scope){ should == "affordability.activemodel"}
    end
  end
end
