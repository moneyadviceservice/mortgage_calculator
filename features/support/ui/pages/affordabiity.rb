require_relative '../sections/slider'

module UI
  module Pages
    class Affordability < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/affordability-calculator"

      element :annual_income, "form.new_affordability input[name='affordability[people_attributes][0][annual_income]'][type='text']"
      element :extra_income, "form.new_affordability input[name='affordability[people_attributes][0][extra_income]'][type='text']"
      element :monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][0][monthly_net_income]'][type='text']"

      element :person_two_annual_income, "form.new_affordability input[name='affordability[people_attributes][1][annual_income]'][type='text']"
      element :person_two_extra_income, "form.new_affordability input[name='affordability[people_attributes][1][extra_income]'][type='text']"
      element :person_two_monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][1][monthly_net_income]'][type='text']"

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

      element :borrowing, "input[name='affordability[borrowing]']"
      element :interest_rate, "input[name='affordability[interest_rate]']"

      section :borrowing_slider, UI::Sections::Slider, "#borrowing-amount-slider"
      section :interest_rate_slider, UI::Sections::Slider, "#slider-interest-rate"

      element :h1, "h1"
      element :h2, "h2"
      element :results, "p[class='results']"

      elements :nexts, "input[value='Find out how much I can borrow']"
      element :recalculate, "input[value='Recalculate']"

      def step_1_next
        nexts.first
      end

      def step_2_next
        # javascript version renders both forms
        nexts[1] || nexts[0]
      end
    end

    class SyndicatedAffordability < Affordability
      set_url "/en/mortgage_calculator/affordability-calculator?syndicated"
    end
  end
end

