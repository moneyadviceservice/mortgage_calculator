module MortgageCalculator
  # base class and common logic for tax calculators
  class TaxCalculator
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper

    attr_reader :price
    attr_accessor :buyer_type
    currency_inputs :price
    validates :price, presence: true, numericality: true

    SECOND_HOME_THRESHOLD = 40_000
    SECOND_HOME_ADDITIONAL_TAX = 3

    def initialize(price: 0, buyer_type: 'isNextHome')
      self.price = price
      self.buyer_type = buyer_type
    end

    %i[price tax_due total_due].each do |field|
      define_method "#{field}_formatted" do
        number_to_currency(
          public_send(field).presence || 0, unit: '', precision: 0
        )
      end
    end

    def tax_due
      self.class.banding_for(bands_to_use).map do |band|
        tax_for_band(band[:start], band[:end], band[:rate])
      end.inject(:+)
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

    def self.banding_for(figures)
      figures.map.with_index do |band, i|
        prev_threshold = 0
        prev_threshold = figures[i - 1][:threshold] + 0.01 unless i.zero?
        {
          start: prev_threshold,
            end: band[:threshold],
           rate: band[:rate]
        }
      end
    end

    protected

    def bands
      Raise 'bands must be implemented'
    end

    def second_home_taxable?
      second_home? && price >= SECOND_HOME_THRESHOLD
    end

    def tax_for_band(band_start, band_end, rate)
      return 0 if price < band_start
      rate += SECOND_HOME_ADDITIONAL_TAX if second_home_taxable?
      upper_limit = price_in_band?(band_end) ? price : band_end
      amount_to_tax = upper_limit - band_start.floor
      (amount_to_tax * rate / 100).floor
    end

    def price_in_band?(band_end)
      band_end.nil? || price <= band_end
    end
  end
end
