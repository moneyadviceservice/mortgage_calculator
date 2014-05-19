module UI
  module Pages
    class Affordability < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/affordability-calculator"

      element :annual_income, "form.new_affordability input[name='affordability[people_attributes][0][annual_income]']"
      element :extra_income, "form.new_affordability input[name='affordability[people_attributes][0][extra_income]']"
      element :monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][0][monthly_net_income]']"

      element :person_two_annual_income, "form.new_affordability input[name='affordability[people_attributes][1][annual_income]']"
      element :person_two_extra_income, "form.new_affordability input[name='affordability[people_attributes][1][extra_income]']"
      element :person_two_monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][1][monthly_net_income]']"

      element :credit_repayments, "form.new_affordability input[name='affordability[outgoings][credit_repayments]']"
      element :child_maintenance, "form.new_affordability input[name='affordability[outgoings][child_maintenance]']"

      element :childcare, "form.new_affordability input[name='affordability[outgoings][childcare]']"
      element :travel, "form.new_affordability input[name='affordability[outgoings][travel]']"
      element :utilities, "form.new_affordability input[name='affordability[outgoings][utilities]']"
      element :rent_and_mortgage, "form.new_affordability input[name='affordability[outgoings][rent_and_mortgage]']"

      element :food, "form.new_affordability input[name='affordability[outgoings][food]']"
      element :entertainment, "form.new_affordability input[name='affordability[outgoings][entertainment]']"
      element :holiday, "form.new_affordability input[name='affordability[outgoings][holidays]']"
      element :food, "form.new_affordability input[name='affordability[outgoings][food]']"

      element :interest_rate, "input[name='affordability[interest_rate]']"

      element :h1, "h1"
      element :h2, "h2"
      element :results, "p[class='results']"

      element :next, "input[value='Find out how much I can borrow']"
      element :recalculate, "input[value='Recalculate']"
    end
  end
end

