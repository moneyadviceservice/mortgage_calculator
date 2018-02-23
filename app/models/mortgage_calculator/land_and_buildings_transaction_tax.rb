module MortgageCalculator
  class LandAndBuildingsTransactionTax < TaxCalculator
    def self.i18n_scope
      'land_and_buildings_transaction_tax.activemodel'
    end

    STANDARD_BANDS = [
      { threshold: 145_000, rate: 0 },
      { threshold: 250_000, rate: 2 },
      { threshold: 325_000, rate: 5 },
      { threshold: 750_000, rate: 10 },
      { threshold: nil, rate: 12 }
    ].freeze

    protected

    def bands_to_use
      STANDARD_BANDS
    end
  end
end
