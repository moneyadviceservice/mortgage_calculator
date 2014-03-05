module UI
  module Pages
    class Repayment < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/repayment"

      element :price, "input[name='repayment[price]']"
      element :deposit, "input[name='repayment[deposit]']"
      element :term_years, "input[name='repayment[term_years]']"
      element :interest_rate, "input[name='repayment[interest_rate]']"
      element :submit, "input[type=submit]"
    end
  end
end

