require 'spec_helper'

module MortgageCalculator
  describe LocalizeRoute do
    include MortgageCalculator::Engine.routes.url_helpers

    let(:routes_proxy) do
      class TestRoutesProxy
        include MortgageCalculator::Engine.routes.url_helpers
      end.new
    end

    context 'when en' do
      subject{ described_class.new("affordability_path", :en, routes_proxy) }

      it 'returns en route' do
        expect(subject.call).to eql(affordability_path)
      end
    end

    context 'when cy' do
      subject{ described_class.new("affordability_path", :cy, routes_proxy) }

      it 'returns cy route' do
        expect(subject.call).to eql(affordability_cy_path)
      end
    end
  end
end
