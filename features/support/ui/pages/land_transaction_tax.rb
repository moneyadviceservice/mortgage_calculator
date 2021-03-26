require_relative './stamp_duty'

module UI
  module Pages
    class LandTransactionTax < UI::Pages::StampDuty
      include DefaultLocale

      set_url '/{locale}/mortgage_calculator/land-transaction-tax-calculator-wales'
      element :buyer_type, "form.step_one select[name='buyer_type']"
      element :buyer_type_select, "#new_land_transaction_tax > label.stamp-duty__buyer-type"

      element :property_price, "form.step_one input[name='land_transaction_tax[price]']"
      element :property_price_step_two, "form.step_two input[name='land_transaction_tax[price]']"

      element :completion_date_year, "form.step_one #land_transaction_tax_completion_date_1i"
      element :completion_date_month, "form.step_one #land_transaction_tax_completion_date_2i"
      element :completion_date_day, "form.step_one #land_transaction_tax_completion_date_3i"

      element :completion_date_year_step_two, "form.step_two #land_transaction_tax_completion_date_1i"
      element :completion_date_month_step_two, "form.step_two #land_transaction_tax_completion_date_2i"
      element :completion_date_day_step_two, "form.step_two #land_transaction_tax_completion_date_3i"
    end
  end
end
