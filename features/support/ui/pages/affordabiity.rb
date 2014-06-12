require_relative '../sections/slider'

module UI
  module Pages
    class Affordability < SitePrism::Page
      include DefaultLocale

      set_url "/{locale}/mortgage_calculator/mortgage-affordability-calculator"

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
      element :lifestyle, "input[name='affordability[lifestyle_costs]']"

      section :borrowing_slider, UI::Sections::Slider, "#slider-borrowing"
      section :interest_rate_slider, UI::Sections::Slider, "#slider-interest-rate"
      section :lifestyle_slider, UI::Sections::Slider, "#slider-lifestyle"

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
      set_url "/en/mortgage_calculator/mortgage-affordability-calculator?syndicated"
    end

    class WelshAffordability < Affordability
      set_url "/cy/mortgage_calculator/morgais-cyfrifiannell-fforddiadwyedd"
    end
  end
end

