module UI
  module Pages
    class Repayment < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/repayment"

      element :price, "form.new_repayment input[name='repayment[price]']"
      element :deposit, "form.new_repayment input[name='repayment[deposit]']"
      element :next, "form.new_repayment input[type=submit]"

      element :step_two_price, "form.step_two input[name='repayment[price]']"
      element :step_two_deposit, "form.step_two input[name='repayment[deposit]']"
      element :term_years, "input[name='repayment[term_years]']"
      element :interest_rate, "input[name='repayment[interest_rate]']"
      element :recalculate, "form.step_two input[type=submit]"
    end
  end
end

