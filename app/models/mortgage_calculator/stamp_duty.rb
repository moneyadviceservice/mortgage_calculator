module MortgageCalculator
  class StampDuty
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper

    def self.i18n_scope
      "stamp_duty.activemodel"
    end

    RATES = {
      125000 => 0,
      250000 => 2,
      925000 => 5,
      1500000 => 10,
      1000000000 => 12
    }

    SDLT_RATES = [
      {lower: 0,         upper: 125_000,   first_home: 0,  additional_or_buy_to_let: 3},
      {lower: 125_001,   upper: 250_000,   first_home: 2,  additional_or_buy_to_let: 5},
      {lower: 250_001,   upper: 925_000,   first_home: 5,  additional_or_buy_to_let: 8},
      {lower: 925_001,   upper: 1_500_000, first_home: 10, additional_or_buy_to_let: 13},
      {lower: 1_500_001, upper: nil,       first_home: 12, additional_or_buy_to_let: 15}
    ].freeze
    
    SECOND_HOME_THRESHOLD = 40000
    SECOND_HOME_RATE = 3.0

    attr_reader :price
    attr_accessor :second_home

    currency_inputs :price

    validates :price, presence: true, numericality: true

    def initialize(options = {})
      self.price = options.fetch(:price){ 0 }
      self.second_home = options.key?(:second_home) && options[:second_home] == "true"
    end

    [:price, :tax_due, :total_due].each do |field|
      define_method "#{field}_formatted" do
        number_to_currency(public_send(field).presence || 0, unit: '', precision: 0)
      end
    end

    def tax_due
      total_tax = BigDecimal('0')
      remaining = price

      RATES.each_with_index do |array, index|
        threshold, rate = array
        bandwidth = RATES.keys.unshift(0)[index + 1] - RATES.keys.unshift(0)[index]
        remaining_taxable = [threshold, remaining].min
        band_taxable = [bandwidth, remaining_taxable].min
        total_tax = total_tax + (band_taxable * rate/100)
        remaining -= bandwidth
        break if remaining < 0
      end

      if self.second_home && price >= SECOND_HOME_THRESHOLD
        total_tax += price * (SECOND_HOME_RATE / 100)
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
  end
end
