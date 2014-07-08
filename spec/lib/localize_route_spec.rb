require 'spec_helper'

module MortgageCalculator
  describe LocalizeRoute do
    include MortgageCalculator::Engine.routes.url_helpers

    context 'when en' do
      subject{ described_class.new("affordability_path") }

      it 'returns en route' do
        expect(subject.call).to eql(affordability_path)
      end
    end

    context 'when cy' do
      subject{ described_class.new("affordability_path", :cy) }

      it 'returns cy route' do
        expect(subject.call).to eql(affordability_cy_path)
      end
    end
  end
end
