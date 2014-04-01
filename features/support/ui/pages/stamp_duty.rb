module UI
  module Pages
    class StampDuty < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/stamp_duty"

      element :property_price, "input[name='stamp_duty[price]']"
      element :h2, "h2"
      element :results, "p[class='results']"
      element :submit, "input[type=submit]"
    end
  end
end

