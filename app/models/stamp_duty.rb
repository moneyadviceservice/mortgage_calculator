module MortgageCalculator
  class StampDuty
    attr_reader :price

    def initialize(options = {})
      @price = options[:price] || 0
    end

    def percentage_rate
      lookup = {
        125000 => 0,
        250000 => 1,
        500000 => 3,
        1000000 => 4,
        2000000 => 5
      }

      BigDecimal(Array(lookup.detect{|k,_| price <= k}).last || 7)
    end

    def tax_due
      (price * rate).to_i
    end

    def total_due
      price + tax_due
    end

    private

    def rate
      percentage_rate / 100
    end
  end
end

