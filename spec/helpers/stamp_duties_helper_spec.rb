require 'spec_helper'

module MortgageCalculator
  describe StampDutiesHelper do
    describe '#band' do
      context 'when there is a lower and an upper limit' do
        it 'returns a currency range with both limits formatted' do
          expect(band(0, 125000)).to eq('£0 - £125,000')
        end
      end

      context 'for the maximum band' do
        it 'returns text for the maximum band' do
          expect(band(1500001, nil)).to eq('Over £1.5 million')
        end
      end
    end

    describe '#second_home_threshold' do
      it 'returns the second home threshold formatted with a currency sign' do
        expect(second_home_threshold).to eq('£40,000')
      end
    end

    describe '#ftb_threshold' do
      it 'returns the first time buyer threshold formatted with a currency sign' do
        expect(ftb_threshold).to eq('£500,000')
      end
    end

    describe '#calculator_config_json' do
      it 'it sets first threshold to the correct value' do
        config = JSON.parse(calculator_config_json)
        expect(config["standard"].first["threshold"]).to eq(250_000)
      end
    end
  end
end
