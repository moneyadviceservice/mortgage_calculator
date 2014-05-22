module UI
  module Pages
    class StampDuty < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/stamp-duty-calculator"

      element :h1, "h1"
      element :h2, "h2"
      element :property_price, "form.step_one input[name='stamp_duty[price]']"
      element :property_price_step_two, "form.step_two input[name='stamp_duty[price]']"

      element :next, "form.step_one input[type=submit]"
      element :next_steps, "a[href^='/en/mortgage_calculator/stamp_duty/next_steps']"

      element :results, "p[class='results']"
      element :results_text, "p[class='results-text']"

      element :recalculate, "form.step_two input[type=submit]"
    end
  end
end

module UI
  module Pages
    class WelshStampDuty < StampDuty
      set_url "/cy/mortgage_calculator/treth_stamp"
    end
  end
end
