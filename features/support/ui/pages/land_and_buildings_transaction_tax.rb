require_relative './stamp_duty'

module UI
  module Pages
    class LandAndBuildingsTransactionTax < UI::Pages::StampDuty
      include DefaultLocale

      set_url '/{locale}/mortgage_calculator/land-and-buildings-transaction-tax-calculator'
      element :buyer_type, "form.step_one select[name='buyer_type']"
      element :property_price, "form.step_one input[name='land_and_buildings_transaction_tax[price]']"
      element :property_price_step_two, "form.step_two input[name='land_and_buildings_transaction_tax[price]']"
    end
  end
end
