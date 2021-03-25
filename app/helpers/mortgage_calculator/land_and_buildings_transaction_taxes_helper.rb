module MortgageCalculator
  module LandAndBuildingsTransactionTaxesHelper
    include PhaseHelper

    SAMPLE_JOURNEYS = [145_000, 155_000, 175_000, 250_000, 325_500, 750_500].freeze

    def band(num1, num2)
      num1 = num1.ceil
      return minimum_band(num2) if num1.zero?
      return maximum_band(num1 - 1) if num2.nil?

      "#{formatted_currency(num1)} - #{formatted_currency(num2)}"
    end

    def second_home_rate(_rate)
      LandAndBuildingsTransactionTax::SECOND_HOME_ADDITIONAL_TAX
    end

    def first_time_buyer?
      resource.first_time_buy?
    end

    def second_home_threshold
      formatted_currency(
        MortgageCalculator::LandAndBuildingsTransactionTax::SECOND_HOME_THRESHOLD
      )
    end

    def completion_date
      resource.completion_date
    end

    def calculator_config_json
      {
        tool: 'lbtt',
        completion_date: completion_date,
        standard: calculator::STANDARD_BANDS[phase],
        ftb: calculator::FIRST_TIME_BUYER_BANDS[phase],
        second_home_tax_rate: calculator::SECOND_HOME_ADDITIONAL_TAX,
        second_home_threshold: calculator::SECOND_HOME_THRESHOLD,
        first_time_buyer_threshold: 0
      }.to_json
    end

    def outside_first_time_rate?
      resource.first_time_ineligible?
    end

    def ftb_threshold
      formatted_currency(0)
    end

    def ftb_starting_price
      formatted_currency(calculator::FIRST_TIME_BUYER_BANDS[phase].first[:threshold])
    end

    def buyer_journey_examples
      SAMPLE_JOURNEYS.map do |purchase_price|
        {
          purchase_price: formatted_price(purchase_price),
          standard_lbtt: formatted_currency(standard_lbtt(purchase_price)),
          ftb_relief: ftb_relief(purchase_price),
          ftb_lbtt: formatted_currency(ftb_lbtt(purchase_price))
        }
      end
    end

    private

    def minimum_band(num)
      I18n.t(
        'land_and_buildings_transaction_tax.table.min',
        value: formatted_currency(num)
      )
    end

    def maximum_band(num)
      I18n.t(
        'land_and_buildings_transaction_tax.table.max',
        value: formatted_currency(num)
      )
    end

    def formatted_currency(num)
      number_to_currency(num, precision: 0)
    end

    def formatted_price(num)
      threshold = calculator::STANDARD_BANDS[phase].first[:threshold]

      num <= threshold ? minimum_band(threshold) : formatted_currency(num)
    end

    def property_tax(price, buyer_type)
      calculator.new(price: price, buyer_type: buyer_type).tax_due
    end

    def standard_lbtt(price)
      property_tax(
        price, MortgageCalculator::TaxCalculator::STANDARD_BUYER_TYPE
      )
    end

    def ftb_lbtt(price)
      property_tax(
        price, MortgageCalculator::TaxCalculator::FIRST_TIME_BUYER_TYPE
      )
    end

    def ftb_relief(price)
      formatted_currency(standard_lbtt(price) - ftb_lbtt(price))
    end

    def calculator
      MortgageCalculator::LandAndBuildingsTransactionTax
    end
  end
end
