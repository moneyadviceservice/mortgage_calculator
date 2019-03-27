require 'spec_helper'

module MortgageCalculator
  describe PropertyTaxCalculatorHelper, type: :helper do
    describe '#additional_property_rate' do
      context 'when Stamp Duty Calculator' do
        let(:resource) { MortgageCalculator::StampDuty.new }

        it 'returns the Stamp Duty\'s Second Home Tax constant' do
          expect(additional_property_rate).to eq(3)
        end
      end

      context 'when Land and Buildings Transaction Tax(LBTT) Calculator' do
        let(:resource) { MortgageCalculator::LandAndBuildingsTransactionTax.new }

        it 'returns the LBTT\'s Second Home Tax constant' do
          expect(additional_property_rate).to eq(4)
        end
      end

      context 'when Land Transaction Tax(LTT) Calculator' do
        let(:resource) { MortgageCalculator::LandTransactionTax.new }

        it 'returns the LTT\'s Second Home Tax constant' do
          expect(additional_property_rate).to eq(3)
        end
      end
    end
  end
end
