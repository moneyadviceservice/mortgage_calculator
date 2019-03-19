require 'spec_helper'

module MortgageCalculator
  describe LandAndBuildingsTransactionTaxesHelper do
    describe '#calculator_config_json' do
      it 'sets the first theshold to the correct value' do
        config = JSON.parse(calculator_config_json)
        expect(config["standard"].first["threshold"]).to eq(145000)
      end
    end

    describe '#band' do
      context 'when there is a lower and an upper limit' do
        it 'returns a currency range with both limits formatted' do
          expect(band(0, 125000)).to eq('Up to £125,000')
        end
      end

      context 'with the maximum band' do
        it 'returns text for the maximum band' do
          expect(band(1500001, nil)).to eq('Over £1,500,000')
        end
      end
    end

    describe '#second_home_threshold' do
      it 'returns the second home threshold formatted with a currency sign' do
        expect(second_home_threshold).to eq('£40,000')
      end
    end

    describe '#buyer_journey_examples' do
      # rubocop:disable RSpec/ExampleLength
      it 'returns array of example purchase prices with tax relief amounts' do
        expected_result = [
          { purchase_price: 'Up to £145,000', standard_lbtt: '£0', ftb_relief: '£0', ftb_lbtt: '£0' },
          { purchase_price: '£155,000', standard_lbtt: '£200', ftb_relief: '£200', ftb_lbtt: '£0' },
          { purchase_price: '£175,000', standard_lbtt: '£600', ftb_relief: '£600', ftb_lbtt: '£0' },
          { purchase_price: '£250,000', standard_lbtt: '£2,100', ftb_relief: '£600', ftb_lbtt: '£1,500' },
          { purchase_price: '£325,500', standard_lbtt: '£5,900', ftb_relief: '£600', ftb_lbtt: '£5,300' },
          { purchase_price: '£750,500', standard_lbtt: '£48,410', ftb_relief: '£600', ftb_lbtt: '£47,810' }
        ]

        expect(buyer_journey_examples).to eq(expected_result)
      end
      # rubocop:enable RSpec/ExampleLength
    end

    describe '#ftb_starting_price' do
      it 'returns the formatted price at which lbtt becomes payable for first time buyers' do
        expect(ftb_starting_price).to eq('£175,000')
      end
    end
  end
end
