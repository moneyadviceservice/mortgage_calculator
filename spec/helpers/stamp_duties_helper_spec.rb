require 'spec_helper'

module MortgageCalculator
  describe StampDutiesHelper do
    describe '#band' do
      context 'when there is a lower and an upper limit' do
        it 'returns a currency range with both limits formatted' do
          expect(band(0, 125000) ).to eq("£0 - £125,000")
        end
      end

      context 'for the maximum band' do
        it 'returns text for the maximum band' do
          expect(band(1500001, nil) ).to eq("Over £1.5 million")
        end
      end
    end
  end
end
