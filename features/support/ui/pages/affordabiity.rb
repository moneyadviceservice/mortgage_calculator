module UI
  module Pages
    class Affordability < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/affordability-calculator"

      element :annual_income, "input[name='affordability[people_attributes][0][annual_income]']"
      element :extra_income, "input[name='affordability[people_attributes][0][extra_income]']"
      element :person_two_annual_income, "input[name='affordability[people_attributes][1][annual_income]']"
      element :person_two_extra_income, "input[name='affordability[people_attributes][1][extra_income]']"
      element :monthly_debt, "input[name='affordability[monthly_debt]']"
      element :h1, "h1"
      element :results, "p[class='results']"
    end
  end
end

