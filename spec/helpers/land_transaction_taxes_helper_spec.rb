require 'spec_helper'

module MortgageCalculator
  describe LandTransactionTaxesHelper do
    describe '#calculator_config_json' do
      it 'sets the first theshold to the correct value' do
        config = JSON.parse(calculator_config_json)
        expect(config["standard"].first["threshold"]).to eq(180000)
      end
    end
  end
end
