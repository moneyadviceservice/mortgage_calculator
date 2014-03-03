module PageObjects
  class StampDuty < SitePrism::Page
    set_url "/en/mortgage_calculator/stamp_duty"

    element :property_price, "input[name='stamp_duty[price]']"
    element :h1, "h1"
    element :results, "p[class='results']"
  end
end
