module UI
  module Pages
    class StampDuty < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/stamp-duty-calculator"

      element :h1, "h1"
      element :h2, "h2"
      element :property_price, "form.step_one input[name='stamp_duty[price]']"
      element :property_price_step_two, "form.step_two input[name='stamp_duty[price]']"
      element :second_home, "form.step_one input[name='stamp_duty[second_home]'][type='checkbox']"
      element :second_home_step_two, "form.step_two input[name='stamp_duty[second_home]'][type='checkbox']"

      element :next, "form.step_one input[type=submit]"
      element :next_steps, "a[href^='/en/mortgage_calculator/stamp-duty-calculator/next_steps']"

      element :results, "p[class='results']"
      element :results_text, "p[class='results-text']"

      element :recalculate, "form.step_two input[type=submit]"
    end

    class WelshStampDuty < StampDuty
      set_url "/cy/mortgage_calculator/treth_stamp"
    end

    class SyndicatedStampDuty < StampDuty
      set_url "/en/mortgage_calculator/stamp-duty-calculator?syndicated"
    end
  end
end

