module MortgageCalculator
  # base class and common logic for tax calculators
  class TaxCalculator
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper

    attr_reader :price
    attr_accessor :buyer_type
    attr_accessor :completion_date
    currency_inputs :price
    validates :price, presence: true, numericality: true
    validate :completion_date_is_in_the_future

    SECOND_HOME_THRESHOLD = 40_000
    STANDARD_BUYER_TYPE = 'isNextHome'.freeze
    FIRST_TIME_BUYER_TYPE = 'isFTB'.freeze
    SECOND_PROPERTY_BUYER = 'isSecondHome'.freeze

    def initialize(price: 0, buyer_type: STANDARD_BUYER_TYPE, completion_date: Date.tomorrow)
      self.price = price
      self.buyer_type = buyer_type
      self.completion_date = completion_date
    end

    def price_formatted
      format_currency(price || 0)
    end

    def tax_due_formatted
      format_currency(tax_due || 0)
    end

    def total_due_formatted
      format_currency(total_due || 0)
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
      buyer_type == SECOND_PROPERTY_BUYER
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

    def completion_date_is_in_the_future
      errors.add(:completion_date, 'must be present') && return unless completion_date.present?
      errors.add(:completion_date, 'invalid date') && return unless valid_date?(completion_date)
      errors.add(:completion_date, 'must be in the future') && return unless completion_date.to_date.future?
    end

    def valid_date?(value)
      return true if value.is_a?(Date) || value.is_a?(Time)

      d, m, y = value.split('/')
      Date.valid_date?(y.to_i, m.to_i, d.to_i)
    end

    def bands_to_use
      Raise 'bands must be implemented'
    end

    def second_home_taxable?
      second_home? && price >= SECOND_HOME_THRESHOLD
    end

    def tax_for_band(band_start, band_end, rate)
      return 0 if price < band_start
      rate += self.class::SECOND_HOME_ADDITIONAL_TAX if second_home_taxable?
      upper_limit = price_in_band?(band_end) ? price : band_end
      amount_to_tax = upper_limit - band_start.floor
      (amount_to_tax * rate / 100).floor
    end

    def price_in_band?(band_end)
      band_end.nil? || price <= band_end
    end

    def format_currency(value, precision = 0)
      number_to_currency(value, unit: '', precision: precision)
    end
  end
end
