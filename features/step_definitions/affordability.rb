# encoding: utf-8

Given /^I visit the Affordability (?:page|calculator)$/i do
  step_one.load
end

When(/^I enter all details for single applicant$/) do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "6000"
  step_one.next.click
  step_two.credit_repayments.set "300"
  step_two.utilities.set "300"
  step_two.childcare.set "300"
  step_two.child_maintenance.set "300"
  step_two.rent_and_mortgage.set "300"
  step_two.food.set "300"
  step_two.travel.set "300"
  step_two.entertainment.set "300"
  step_two.holiday.set "300"
  step_two.next.click

  @min_affordability_should_eq = "£287,840"
  @max_affordability_should_eq = "£431,760"
end

Then(/^I should see how much I can borrow$/) do
  expect(page).to have_content(
    I18n::t("affordability.range.offer_html",
       min: @min_affordability_should_eq,
       max: @max_affordability_should_eq)
    )
end

When(/^I enter invalid details on step one for single applicant$/) do
  step_one.annual_income.set "ABC"
  step_one.extra_income.set "-10000"
  step_one.monthly_net_income.set ""
  step_one.next.click
end

Then(/^I should see a list of errors$/) do
  expect(page).to have_content(I18n::t("dough.forms.validation.summary.title"))
end

Given(/^I enter valid details on step one for single applicant$/) do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "6000"
  step_one.next.click
end

When(/^I enter invalid details on step two$/) do
  step_two.credit_repayments.set "ABC"
  step_two.utilities.set "-300"
  step_two.childcare.set "DEF"
  step_two.child_maintenance.set "%&*"
  step_two.rent_and_mortgage.set "GHI"
  step_two.food.set "JKL"
  step_two.travel.set "MNO"
  step_two.entertainment.set "PQR"
  step_two.holiday.set "STU"
  step_two.next.click
end

Given(/^I enter valid details on step two$/) do
  step_two.credit_repayments.set "300"
  step_two.utilities.set "300"
  step_two.childcare.set "300"
  step_two.child_maintenance.set "300"
  step_two.rent_and_mortgage.set "300"
  step_two.food.set "300"
  step_two.travel.set "300"
  step_two.entertainment.set "300"
  step_two.holiday.set "300"
  step_two.next.click
end

When(/^I recalculate with invalid details$/) do
  pending # Never worked, so new test fails
  step_three.borrowing.set "ABC"
  step_three.interest_rate.set "-999999"
  step_three.recalculate.click
end

When(/^I enter invalid details on step one for two applicants$/) do
  step_one.annual_income.set "ABC"
  step_one.extra_income.set "-10000"
  step_one.monthly_net_income.set ""
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set "DEF"
  step_one.person_two_extra_income.set "-9999"
  step_one.person_two_monthly_net_income.set "2000"
  step_one.next.click
end

Given(/^I enter valid details on step one for two applicants$/) do
  step_one.annual_income.set "24000"
  step_one.extra_income.set "1000"
  step_one.monthly_net_income.set "1200"
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set "32000"
  step_one.person_two_extra_income.set "1500"
  step_one.person_two_monthly_net_income.set "1500"
  step_one.next.click
end

Given(/^I enter all details for two applicants$/) do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "6000"
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set "32000"
  step_one.person_two_extra_income.set "1500"
  step_one.person_two_monthly_net_income.set "1500"
  step_one.next.click
  step_two.credit_repayments.set "300"
  step_two.utilities.set "300"
  step_two.childcare.set "300"
  step_two.child_maintenance.set "300"
  step_two.rent_and_mortgage.set "300"
  step_two.food.set "300"
  step_two.travel.set "300"
  step_two.entertainment.set "300"
  step_two.holiday.set "300"
  step_two.next.click

  @min_affordability_should_eq = "£381,640"
  @max_affordability_should_eq = "£572,460"
end

When(/^I enter too much monthly income for single applicant$/) do
  step_one.annual_income.set "24000"
  step_one.monthly_net_income.set "2200"
  step_one.next.click
end

When(/^I enter too much monthly income for two applicants$/) do
  step_one.annual_income.set "24000"
  step_one.extra_income.set "2200"
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set "32000"
  step_one.person_two_monthly_net_income.set "2800"
  step_one.next.click
end

When(/^I enter too much monthly income for the second applicant$/) do
  step_one.annual_income.set "24000"
  step_one.extra_income.set "100"
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set "32000"
  step_one.person_two_monthly_net_income.set "2800"
  step_one.next.click
end

Then(/^I should see different errors for the second applicant$/) do
  pending # this needs implementing
  expect(page).to have_content(
    I18n::t("affordability.activemodel.errors.mortgage_calculator/person_other.base.proportional_incomes"))
end

Given(/^I enter various income and expense details$/) do

  calculations.each do |key, calculation|
    step_one.load
    step_one.annual_income.set calculation['annual_income']
    step_one.extra_income.set calculation['extra_income']
    step_one.monthly_net_income.set calculation['monthly_net_income']

    if calculation['person_two_annual_income'] > 0
      step_one.second_applicant.set "1"
      step_one.person_two_annual_income.set calculation['person_two_annual_income']
      step_one.person_two_extra_income.set calculation['person_two_extra_income']
      step_one.person_two_monthly_net_income.set calculation['person_two_monthly_net_income']
    end
    # save_and_open_screenshot

    step_one.next.click
    step_two.credit_repayments.set calculation['credit_repayments']
    step_two.utilities.set calculation['utilities']
    step_two.childcare.set calculation['childcare']
    step_two.child_maintenance.set calculation['child_maintenance']
    step_two.rent_and_mortgage.set calculation['rent_and_mortgage']
    step_two.food.set calculation['food']
    step_two.travel.set calculation['travel']
    step_two.entertainment.set calculation['entertainment']
    step_two.holiday.set calculation['holiday']
    step_two.next.click

    expect(page).to have_content("between #{calculation['range_min']} and #{calculation['range_max']}")
    expect(page).to have_content("Your estimated mortgage repayments per month will be approximately: #{calculations['repayment_per_month']}")
    expect(page).to have_content("The amount you have left over after living costs is #{calculation['remaining_per_month']}")
    expect(page).to have_content("Your estimated fixed and committed spend per month is: #{calculation['spending_commitments']}")
    expect(page).to have_content("If interest rates rise by 2%, your monthly repayment will rise to #{calculation['increased_monthly_repayment']}")
    expect(page).to have_content("Your remaining budget will be #{calculation['financial_buffer']}")

    Capybara.reset_sessions!
  end

end

Then(/^I should see accurate calculations$/) do
  # blank because expectations made in
  # Given(/^I enter various income and expense details$/) do
end

When(/^I enter details giving negative remaining amount$/) do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "6000"
  step_one.next.click
  step_two.credit_repayments.set "10000"
  step_two.utilities.set "300"
  step_two.childcare.set "300"
  step_two.child_maintenance.set "300"
  step_two.rent_and_mortgage.set "300"
  step_two.food.set "300"
  step_two.travel.set "300"
  step_two.entertainment.set "300"
  step_two.holiday.set "300"
  step_two.next.click
end


When(/^I refine my affordability interest rate$/) do
  step_three.interest_rate.set(4)
end

When(/^I refine my affordability interest rate slider$/) do
  step_three.interest_rate_slider.set(4)
end

When(/^I refine my affordability lifestyle$/) do
  step_three.lifestyle.set(4)
end

When(/^I refine my affordability lifestyle slider$/) do
  step_three.lifestyle_slider.set(1000)
end

When(/^I refine my affordability borrowing$/) do
  step_three.borrowing_slider.set(300000)
end

Given(/^I visit the Syndicated Affordability page$/) do
  @affordability = UI::Pages::Affordability::SyndicatedAffordability.new
  @affordability.load
end
