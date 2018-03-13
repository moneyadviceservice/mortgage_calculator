module MortgageCalculator
  class LandTransactionTax < TaxCalculator
    def self.i18n_scope
      'land_transaction_tax.activemodel'
    end

    STANDARD_BANDS = [
      { threshold: 180_000, rate: 0 },
      { threshold: 250_000, rate: 3.5 },
      { threshold: 400_000, rate: 5 },
      { threshold: 750_000, rate: 7.5 },
      { threshold: 1_500_000, rate: 10 },
      { threshold: nil, rate: 12 }
    ].freeze

    protected

    def bands_to_use
      STANDARD_BANDS
    end
  end
end
