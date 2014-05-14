module UI
  module Pages
    class Affordability < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/affordability-calculator"

      element :annual_income, "input[name='affordability[people_attributes][0][annual_income]']"
      element :extra_income, "input[name='affordability[people_attributes][0][extra_income]']"
      element :monthly_net_income, "input[name='affordability[people_attributes][0][monthly_net_income]']"

      element :person_two_annual_income, "input[name='affordability[people_attributes][1][annual_income]']"
      element :person_two_extra_income, "input[name='affordability[people_attributes][1][extra_income]']"
      element :person_two_monthly_net_income, "input[name='affordability[people_attributes][1][monthly_net_income]']"

      element :credit_repayments, "input[name='affordability[outgoings][credit_repayments]']"
      element :utilities, "input[name='affordability[outgoings][utilities]']"
      element :childcare, "input[name='affordability[outgoings][childcare]']"
      element :child_maintenance, "input[name='affordability[outgoings][child_maintenance]']"
      element :rent_and_mortgage, "input[name='affordability[outgoings][rent_and_mortgage]']"
      element :food, "input[name='affordability[outgoings][food]']"
      element :travel, "input[name='affordability[outgoings][travel]']"
      element :entertainment, "input[name='affordability[outgoings][entertainment]']"

      element :h1, "h1"
      element :h2, "h2"
      element :results, "p[class='results']"

      element :next, "input[value='Find out how much I can borrow']"
    end
  end
end

