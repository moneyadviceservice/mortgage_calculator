require 'spec_helper'

module MortgageCalculator
  describe PersonPresenter do
    let(:model){ Person.new }
    subject{ described_class.new model }

    its(:persisted?){ should be_false }
    its(:annual_income){ should == "0.00" }
    its(:extra_income){ should == "0.00" }

    describe 'class methods' do
      subject{ described_class }

      its(:model_name){ should == "MortgageCalculator::Person" }
    end
  end
end
