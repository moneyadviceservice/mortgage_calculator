module UI
  module Pages
    class Repayment < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/repayment"

      element :price, "form.step_one input[name='repayment[price]']"
      element :deposit, "form.step_one input[name='repayment[deposit]']"
      element :next, "form.step_one input[type=submit]"
      element :next_steps, "a[href^='/en/mortgage_calculator/repayment/next_steps']"

      element :step_two_price, "form.step_two input[name='repayment[price]']"
      element :step_two_deposit, "form.step_two input[name='repayment[deposit]']"
      element :term_years, "input[name='repayment[term_years]']"
      element :interest_rate, "input[name='repayment[interest_rate]']"
      element :recalculate, "form.step_two input[type=submit]"
    end

    class SyndicatedRepayment < Repayment
      set_url "/en/mortgage_calculator/repayment?syndicated"
    end
  end
end

