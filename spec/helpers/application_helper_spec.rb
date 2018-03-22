require 'spec_helper'

module MortgageCalculator
  describe ApplicationHelper do
    describe '#calculator_name' do
      before do
        allow(helper).to receive(:controller_name).and_return(controller_name)
      end

      context 'when repayments controller' do
        let(:controller_name) { 'repayments' }

        it 'returns "mortgage_calculator"' do
          expect(helper.calculator_name).to eq('mortgage_calculator')
        end
      end

      context 'when stamp duties controller' do
        let(:controller_name) { 'stamp_duties' }

        it 'returns "stamp_duty"' do
          expect(helper.calculator_name).to eq('stamp_duty')
        end
      end

      context 'when affordabilities controller' do
        let(:controller_name) { 'affordabilities' }

        it 'returns "affordability"' do
          expect(helper.calculator_name).to eq('affordability')
        end
      end

      context 'when land_and_buildings_transaction_taxes controller' do
        let(:controller_name) do
          'land_and_buildings_transaction_taxes'
        end

        it 'returns "land_and_buildings_transaction_tax"' do
          expect(helper.calculator_name).to eq('land_and_buildings_transaction_tax')
        end
      end

      context 'when land transaction taxes controller' do
        let(:controller_name) do
          'land_transaction_taxes'
        end

        it 'returns "land_transaction_tax"' do
          expect(helper.calculator_name).to eq('land_transaction_tax')
        end
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
