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

    validates :price, numericality: true, unless: Proc.new {|sd| sd.price.blank?}
    validates :price, presence: true

    def initialize(options = {})
      self.price = options.fetch(:price){ nil }
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

