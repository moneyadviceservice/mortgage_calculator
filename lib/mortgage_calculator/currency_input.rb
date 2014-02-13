module MortgageCalculator
  module CurrencyInput
    module Macro
      extend ActiveSupport::Concern

      included do
        def self.currency_inputs(*args)
          args.each do |arg|
            define_method "#{arg}=" do |value|
              instance_variable_set(:"@#{arg}", CurrencyInput::Parser.new(value).parse)
            end
          end
        end
      end
    end

    class Parser
      def initialize(input)
        @input = input
      end

      def parse
        BigDecimal(input.to_s.gsub(",",""))
      end

      private

      attr_reader :input
    end
  end
end
