module MortgageCalculator
  class StampDuty < TaxCalculator
    def self.i18n_scope
      'stamp_duty.activemodel'
    end

    # England and Northern Ireland

    FIRST_TIME_BUYER_BANDS = { phase_1: [{ threshold: 500_000, rate: 0 },
                                         { threshold: 500_001, rate: 5 }],
                               phase_2: [{ threshold: 300_000, rate: 0 },
                                         { threshold: 500_000, rate: 5 }],
                               phase_3: [{ threshold: 300_000, rate: 0 },
                                         { threshold: 500_000, rate: 5 }] }.freeze

    STANDARD_BANDS = { phase_1: [{ threshold: 500_000, rate: 0 },
                                 { threshold: 925_000, rate: 5 },
                                 { threshold: 1_500_000, rate: 10 },
                                 { threshold: nil, rate: 12 }],
                       phase_2: [{ threshold: 250_000, rate: 0 },
                                 { threshold: 925_000, rate: 5 },
                                 { threshold: 1_500_000, rate: 10 },
                                 { threshold: nil, rate: 12 }],
                       phase_3: [{ threshold: 125_000, rate: 0 },
                                 { threshold: 250_000, rate: 2 },
                                 { threshold: 925_000, rate: 5 },
                                 { threshold: 1_500_000, rate: 10 },
                                 { threshold: nil, rate: 12 }] }.freeze

    FIRST_TIME_BUYER_THRESHOLD = 500_000
    SECOND_HOME_ADDITIONAL_TAX = 3

    def first_time_ineligible?
      first_time_buy? && price > FIRST_TIME_BUYER_THRESHOLD
    end

    def first_time_buy?
      buyer_type == 'isFTB'
    end

    protected

    def bands_to_use
      first_time_rate? ? FIRST_TIME_BUYER_BANDS[phase] : STANDARD_BANDS[phase]
    end

    private

    def first_time_rate?
      first_time_buy? && price <= FIRST_TIME_BUYER_THRESHOLD
    end
  end
end
