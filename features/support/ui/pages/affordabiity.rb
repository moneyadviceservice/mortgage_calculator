require_relative '../sections/slider'

module UI
  module Pages
    class Affordability

      class StepOne < SitePrism::Page
        include DefaultLocale

        element :h1, "h1"
        element :h2, "h2"

        element :next, "form.new_affordability input[name='commit'][type='submit']"

        set_url "/{locale}/mortgage_calculator/mortgage-affordability-calculator/step-1"

        element :annual_income, "form.new_affordability input[name='affordability[people_attributes][0][annual_income]'][type='text']"
        element :extra_income, "form.new_affordability input[name='affordability[people_attributes][0][extra_income]'][type='text']"
        element :monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][0][monthly_net_income]'][type='text']"

        element :person_two_annual_income, "form.new_affordability input[name='affordability[people_attributes][1][annual_income]'][type='text']"
        element :person_two_extra_income, "form.new_affordability input[name='affordability[people_attributes][1][extra_income]'][type='text']"
        element :person_two_monthly_net_income, "form.new_affordability input[name='affordability[people_attributes][1][monthly_net_income]'][type='text']"

        element :second_applicant, "form.new_affordability input[id='affordability_two_applicants'][type='checkbox']"

      end

      class StepTwo < SitePrism::Page
      include DefaultLocale

        element :h1, "h1"
        element :h2, "h2"

        set_url "/{locale}/mortgage_calculator/mortgage-affordability-calculator/step-2"

        element :next, "form.new_affordability input[name='commit'][type='submit']"

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

      end

      class StepThree < SitePrism::Page

        include DefaultLocale

        element :h1, "h1"
        element :h2, "h2"

        set_url "/{locale}/mortgage_calculator/mortgage-affordability-calculator/step-3"

        element :recalculate, "input.recalculate-button"

        element :borrowing, "input[name='affordability[borrowing]']"
        element :term_years, "input[name='affordability[term_years]']"
        element :interest_rate, "input[name='affordability[interest_rate]']"
        element :lifestyle, "input[name='affordability[lifestyle_costs]']"

        element :offered_amount_js,    ".t-offered-amount-js"
        element :repayments_js,        ".t-repayments-js"
        element :risk_chart_js,        ".t-risk-chart-js"
        element :essentials_js,        ".t-essentials-js"
        element :total_leftover_js,    ".t-total-leftover-js"
        element :remaining_js,         ".t-remaining-js"
        element :what_if_changes_js,   ".t-what-if-changes-js"
        element :what_if_remaining_js, ".t-what-if-remaining-js"
        element :committed_js,         ".t-committed-js"

        element :offered_amount,    ".t-offered-amount"
        element :repayments,        ".t-repayments"
        element :risk_chart,        ".t-risk-chart"
        element :essentials,        ".t-essentials"
        element :total_leftover,    ".t-total-leftover"
        element :remaining,         ".t-remaining"
        element :what_if_changes,   ".t-what-if-changes"
        element :what_if_remaining, ".t-what-if-remaining"
        element :committed,         ".t-committed"

        section :borrowing_slider, UI::Sections::Slider, "#slider-borrowing"
        section :term_years_slider, UI::Sections::Slider, "#slider-term-years"
        section :interest_rate_slider, UI::Sections::Slider, "#slider-interest-rate"
        section :lifestyle_slider, UI::Sections::Slider, "#slider-lifestyle"
      end

      class SyndicatedAffordability < SitePrism::Page
        set_url "/en/mortgage_calculator/mortgage-affordability-calculator?syndicated"
      end

      class WelshAffordability < SitePrism::Page
        set_url "/cy/mortgage_calculator/morgais-cyfrifiannell-fforddiadwyedd"
      end
    end
  end
end

