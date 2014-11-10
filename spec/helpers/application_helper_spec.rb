require 'spec_helper'

module MortgageCalculator
  describe ApplicationHelper do

    describe "#calculator_name" do
      it "sets the calculator name to 'mortgage_calculator' when repayments controller" do
        allow(helper).to receive(:controller_name).and_return('repayments')
        expect(helper.calculator_name).to eq('mortgage_calculator')
      end

      it "sets the calculator name to 'stamp_duty' when stamp_duties controller" do
        allow(helper).to receive(:controller_name).and_return('stamp_duties')
        expect(helper.calculator_name).to eq('stamp_duty')
      end

      it "sets the calculator name to 'affordability' when affordabilities controller" do
        allow(helper).to receive(:controller_name).and_return('affordabilities')
        expect(helper.calculator_name).to eq('affordability')
      end
    end

    describe 'no_follow?' do
      context 'when tool is not syndicated' do
        before { allow(helper).to receive(:syndicated_tool_request?).and_return(false) }

        it 'returns false' do
          expect(helper.no_follow?).to be_falsey
        end
      end

      context 'when tool is syndicated' do
        before { allow(helper).to receive(:syndicated_tool_request?).and_return(true) }

        it 'returns nofollow' do
          expect(helper.no_follow?).to eql("nofollow")
        end
      end
    end
  end
end
