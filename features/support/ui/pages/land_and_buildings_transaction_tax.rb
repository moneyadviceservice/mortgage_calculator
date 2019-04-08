require_relative './stamp_duty'

module UI
  module Pages
    class LandAndBuildingsTransactionTax < UI::Pages::StampDuty
      include DefaultLocale

      set_url '/{locale}/mortgage_calculator/land-and-buildings-transaction-tax-calculator-scotland'
      element :buyer_type, "form.step_one select[name='buyer_type']"
      element :property_price, "form.step_one input[name='land_and_buildings_transaction_tax[price]']"
      element :property_price_step_two, "form.step_two input[name='land_and_buildings_transaction_tax[price]']"
      element :next, "form.step_one input[type=submit]"
      element :how_is_this_calculated_link, ".stamp-duty__how-calculated-toggle"
      element :call_out_box, ".callout__heading"
      element :call_out_tip, ".stamp-duty__info-tip"
      elements :tax_due, ".stamp-duty__results-tax-rate"
      elements :lbtt_ftb_table_headings, ".mortgagecalc__table.stamp-duty__table thead tr"
      elements :lbtt_how_calculated_examples, ".mortgagecalc__table.stamp-duty__table tbody tr"
    end
  end
end
