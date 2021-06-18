module MortgageCalculator
  class LandAndBuildingsTransactionTax < TaxCalculator
    def self.i18n_scope
      'land_and_buildings_transaction_tax.activemodel'
    end

    # SCOTLAND

    FIRST_TIME_BUYER_BANDS = { phase_1: [{ threshold: 175_000, rate: 0 },
                                         { threshold: 250_000, rate: 2 },
                                         { threshold: 325_000, rate: 5 },
                                         { threshold: 750_000, rate: 10 },
                                         { threshold: nil, rate: 12 }],
                               phase_2: [{ threshold: 175_000, rate: 0 },
                                         { threshold: 250_000, rate: 2 },
                                         { threshold: 325_000, rate: 5 },
                                         { threshold: 750_000, rate: 10 },
                                         { threshold: nil, rate: 12 }],
                               phase_3: [{ threshold: 175_000, rate: 0 },
                                         { threshold: 250_000, rate: 2 },
                                         { threshold: 325_000, rate: 5 },
                                         { threshold: 750_000, rate: 10 },
                                         { threshold: nil, rate: 12 }] }.freeze

    STANDARD_BANDS = { phase_1: [{ threshold: 145_000, rate: 0 },
                                 { threshold: 250_000, rate: 2 },
                                 { threshold: 325_000, rate: 5 },
                                 { threshold: 750_000, rate: 10 },
                                 { threshold: nil, rate: 12 }],
                       phase_2: [{ threshold: 145_000, rate: 0 },
                                 { threshold: 250_000, rate: 2 },
                                 { threshold: 325_000, rate: 5 },
                                 { threshold: 750_000, rate: 10 },
                                 { threshold: nil, rate: 12 }],
                       phase_3: [{ threshold: 145_000, rate: 0 },
                                 { threshold: 250_000, rate: 2 },
                                 { threshold: 325_000, rate: 5 },
                                 { threshold: 750_000, rate: 10 },
                                 { threshold: nil, rate: 12 }] }.freeze

    SECOND_HOME_ADDITIONAL_TAX = 4

    def first_time_ineligible?
      !first_time_buy?
    end

    def first_time_buy?
      buyer_type == 'isFTB'
    end

    protected

    def bands_to_use
      first_time_buy? ? FIRST_TIME_BUYER_BANDS[phase] : STANDARD_BANDS[phase]
    end
  end
end
