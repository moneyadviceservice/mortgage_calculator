module MortgageCalculator
  class StampDuty
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include CurrencyInput::Macro

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

