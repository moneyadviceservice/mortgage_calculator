# encoding: UTF-8

require 'spec_helper'

class TestCurrencyMacro
  include MortgageCalculator::CurrencyInput::Macro

  attr_reader :field

  currency_inputs :field
end

module MortgageCalculator
  module CurrencyInput
    describe Parser do
      describe 'when there are currency symbols' do
        subject{ described_class.new("£1,000") }

        it 'removes them' do
          expect(subject.parse).to eql(BigDecimal.new("1000"))
        end
      end
    end

    describe TestCurrencyMacro do
      it 'stores the raw value' do
        subject.field = "£asd"
        expect(subject.raw_field).to eql('asd')
      end
    end
  end
end
