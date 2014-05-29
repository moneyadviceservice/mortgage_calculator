# encoding: UTF-8

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
        purge_currency_symbols!

        return nil if input.blank?
        return nil unless /\A[0-9, ]*(\.)?(\d)*\z/ =~ input.to_s

        BigDecimal(input.to_s.gsub(",",""))
      end

      private

      attr_accessor :input

      def purge_currency_symbols!
        input.gsub!("£", "") if input.kind_of?(String)
      end
    end
  end
end
