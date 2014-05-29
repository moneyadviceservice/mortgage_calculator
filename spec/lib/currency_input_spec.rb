# encoding: UTF-8

require 'spec_helper'

module MortgageCalculator
  describe CurrencyInput::Parser do
    describe 'when there are currency symbols' do
      subject{ described_class.new("£1,000") }

      it 'removes them' do
        expect(subject.parse).to eql(BigDecimal.new("1000"))
      end
    end
  end
end
