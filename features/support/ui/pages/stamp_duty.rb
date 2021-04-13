module UI
  module Pages
    class StampDuty < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/stamp-duty-calculator"

      elements :h1, "h1"
      element :h2, "h2"

      element :buyer_type, "form.step_one select[name='buyer_type']"
      element :buyer_type_select, "#new_stamp_duty > label"
      element :property_price, "form.step_one input[name='stamp_duty[price]']"
      element :property_price_step_two, "form.step_two input[name='stamp_duty[price]']"

      element :next, "form.step_one input[type=submit]"

      element :results, "p[class='results']"
      element :results_text, "p[class='results-text']"
      element :recalculate, "form.step_two input[type=submit]"
      element :effective_tax, "p.stamp-duty__results-tax-rate"
      element :info_table, ".stamp-duty__explanation-nexthome .stamp-duty__table"
      element :how_calculated, ".stamp-duty__how-calculated-toggle"
      element :ftb_explanation, ".stamp-duty__explanation-firsttimebuyer"
      element :next_home_explanation, ".stamp-duty__explanation-nexthome"
      element :ftb_conditional, ".stamp-duty__FTB_conditional"

      element :completion_date_year, "form.step_one #stamp_duty_completion_date_1i"
      element :completion_date_month, "form.step_one #stamp_duty_completion_date_2i"
      element :completion_date_day, "form.step_one #stamp_duty_completion_date_3i"

      element :completion_date_year_step_two, "form.step_two #stamp_duty_completion_date_1i"
      element :completion_date_month_step_two, "form.step_two #stamp_duty_completion_date_2i"
      element :completion_date_day_step_two, "form.step_two #stamp_duty_completion_date_3i"


    end

    class WelshStampDuty < StampDuty
      set_url "/cy/mortgage_calculator/treth_stamp"
    end

    class SyndicatedStampDuty < StampDuty
      set_url "/en/mortgage_calculator/stamp-duty-calculator?syndicated"
    end
  end
end
