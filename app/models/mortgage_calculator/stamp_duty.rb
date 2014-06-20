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
      2000000 => 7,
      1000000 => 5,
      500000 => 4,
      250000 => 3,
      125000 => 1,
      -1 => 0
    }

    attr_reader :price

    currency_inputs :price

    validates :price, presence: true, numericality: true

    def initialize(options = {})
      self.price = options.fetch(:price){ 0 }
    end

    [:price, :tax_due, :total_due].each do |field|
      define_method "#{field}_formatted" do
        number_to_currency(public_send(field).presence || 0, unit: '', precision: 0)
      end
    end

    def percentage_rate
      BigDecimal(RATES.detect{|value,_| price > value}.last)
    end

    def tax_due
      (price * rate).to_i
    end

    def total_due
      price + tax_due
    end

    def persisted?
      false
    end

    private

    def rate
      percentage_rate / 100
    end
  end
end

