module MortgageCalculator
  # Calculate the stamp duty land tax
  class LandAndBuildingsTransactionTax
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper

    def self.i18n_scope
      'stamp_duty.activemodel'
    end

    STANDARD_BANDS = [
      { lower: 0, upper: 145_000, single_home: 0, second_home: 3 },
      { lower: 145_000.01, upper: 250_000, single_home: 2, second_home: 5 },
      { lower: 250_000.01, upper: 325_000, single_home: 5, second_home: 8 },
      { lower: 325_000.01, upper: 750_000, single_home: 10, second_home: 13 },
      { lower: 750_000.01, upper: nil, single_home: 12, second_home: 15 }
    ].freeze

    SECOND_HOME_THRESHOLD = 40_000

    attr_reader :price
    attr_accessor :buyer_type

    currency_inputs :price
    validates :price, presence: true, numericality: true

    def initialize(options = {})
      self.price = options.fetch(:price) { 0 }
      self.buyer_type = options[:buyer_type] || 'isNextHome'.freeze
    end

    %i[price tax_due total_due].each do |field|
      define_method "#{field}_formatted" do
        number_to_currency(
          public_send(field).presence || 0, unit: '', precision: 0
        )
      end
    end

    def tax_due
      total_tax = 0

      STANDARD_BANDS.each do |band|
        rate = band[tax_rate]
        total_tax += tax_for_band(band, rate)
        break if price_in_band?(band)
      end
      total_tax
    end

    def total_due
      price + tax_due
    end

    def persisted?
      false
    end

    def percentage_tax
      result = (tax_due / price) * 100
      result.nan? ? 0 : result
    end

    def second_home?
      buyer_type == 'isSecondHome'
    end

    private

    def tax_for_band(band, rate)
      upper_limit = price_in_band?(band) ? price : band[:upper]
      amount_to_tax = upper_limit - band[:lower].floor
      (amount_to_tax * rate / 100).floor
    end

    def price_in_band?(band)
      band[:upper].nil? || price <= band[:upper]
    end

    def tax_rate
      second_home_taxable? ? :second_home : :single_home
    end

    def second_home_taxable?
      second_home? && price >= SECOND_HOME_THRESHOLD
    end
  end
end
