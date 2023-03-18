# encoding: utf-8
include MortgageCalculator::Defaults

Given /^I visit the Affordability (?:page|calculator)$/i do
  step_one.load
end

When(/^I enter all details for single applicant$/) do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "7000"
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
  expect(page).to have_content(
    I18n::t("affordability.activemodel.errors.mortgage_calculator/person_other.base.proportional_incomes"))
end


Given(/^I add an income of (\d+), extras of (\d+) and monthly net of (\d+\.?\d*)$/) do |income, extras, monthly|
  step_one.annual_income.set income
  step_one.extra_income.set extras
  step_one.monthly_net_income.set monthly
end

Given(/^a second person with an income of (\d+), extras of (\d+) and monthly net of (\d+\.?\d*)$/) do |income, extras, monthly|
  step_one.second_applicant.set "1"
  step_one.person_two_annual_income.set income
  step_one.person_two_extra_income.set extras
  step_one.person_two_monthly_net_income.set monthly
end

Given(/^household costs of (\d+), (\d+), (\d+), (\d+), (\d+) and (\d+)$/) do |credit, maint, childcare, travel, bills, rent|
  step_one.next.click
  step_two.credit_repayments.set credit
  step_two.child_maintenance.set maint
  step_two.childcare.set childcare
  step_two.travel.set travel
  step_two.utilities.set bills
  step_two.rent_and_mortgage.set rent
end

Given(/^living costs of (\d+), (\d+) and (\d+)$/) do |ents, hols, food|
  step_two.entertainment.set ents
  step_two.holiday.set hols
  step_two.food.set food
  step_two.next.click
end

When(/^I set the term to (\d+) and interest to (\d+)$/) do |term, rate|
  step_three.term_years.set term
  step_three.interest_rate.set rate
  step_three.recalculate.click
end

Then(/^the offered range is expected to be between "([^"]*)" and "([^"]*)"$/) do |min, max|
  expect(step_three.offered_amount).to have_content("between #{min} and #{max}")
end

Then(/^the borrowing amount is expected to be "([^"]*)"$/) do |borrowing|
  expect(step_three.borrowing.value).to eq(borrowing)
end

Then(/^the monthly repayments are expected to be "([^"]*)"$/) do |repayments|
  expect(step_three.repayments).to have_content("Your estimated mortgage repayments per month will be approximately: #{repayments}")
end

Then(/^the current monthly repayments are expected to be "([^"]*)"$/) do |rent_now|
  expect(step_three.rent_and_mortgage).to have_content("Compared with your current rent or mortgage payment of: #{rent_now}")
end

Then(/^the spending commitment is expected to be "([^"]*)"$/) do |commitment|
  expect(step_three.committed).to have_content("Your estimated fixed and committed spend per month is: #{commitment}")
end

Then(/^the risk percentage is expected to be "([^"]*)"$/) do |risk_pct|
  expect(step_three.risk_chart).to have_content("#{risk_pct}")
end

Then(/^the essentials are expected to have a percent of "([^"]*)" and an amount of "([^"]*)"$/) do |percent, amount|
  expect(step_three.essentials).to have_content("Mortgage repayments and essential costs per month amount to roughly #{percent} of your total take-home pay: #{amount}")
end

Then(/^the leftovers are expected to have a percent of "([^"]*)" and an amount of "([^"]*)"$/) do |percent, amount|
  expect(step_three.total_leftover).to have_content("What you have left over is roughly #{percent} of your monthly take-home: #{amount}")
end

Then(/^the remaining per month is expected to be "([^"]*)"$/) do |remaining|
  expect(step_three.remaining).to have_content("The amount you have left over after living costs is #{remaining}")
end

Then(/^the amount on interest increase is expected to be "([^"]*)"$/) do |amount|
  expect(step_three.what_if_changes).to have_content("If interest rates rise by 3%, your monthly repayment will rise to #{amount}")
end

Then(/^the buffer on interest increase is expected to be "([^"]*)"$/) do |buffer|
  expect(step_three.what_if_remaining).to have_content("Your remaining budget will be #{buffer}")
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

Then(/^I should see the correct results for a single applicant$/) do
  expect(js_test? ? step_three.repayments_js : step_three.repayments).to have_text('£2,318.20')
  expect(js_test? ? step_three.risk_chart_js : step_three.risk_chart).to have_text('55%')
  expect(js_test? ? step_three.essentials_js : step_three.essentials).to have_text('55%')
  expect(js_test? ? step_three.essentials_js : step_three.essentials).to have_text('£3,818.20')
  expect(js_test? ? step_three.total_leftover_js : step_three.total_leftover).to have_text('45%')
  expect(js_test? ? step_three.total_leftover_js : step_three.total_leftover).to have_text('£3,181.80')
  expect(js_test? ? step_three.remaining_js : step_three.remaining).to have_text('£2,281.80')
  expect(js_test? ? step_three.what_if_changes_js : step_three.what_if_changes).to have_text(js_test? ? '3%' : '2%')
  expect(js_test? ? step_three.what_if_changes_js : step_three.what_if_changes).to have_text(js_test? ? '£3,019.43' : '£2,103.35')
  expect(js_test? ? step_three.what_if_remaining_js : step_three.what_if_remaining).to have_text(js_test? ? '£1,580.57' : '£1,496.65')
end

# Only runs as a javascript test
Then(/^I should be able to tweak the results by adjusting the interest rate text$/) do
  expect(step_three).to have_interest_rate

  step_three.interest_rate.set(4)

  expect(step_three.repayments_js).to have_text('£1,899.16')
  expect(step_three.risk_chart_js).to have_text('49%')
  expect(step_three.essentials_js).to have_text('49%')
  expect(step_three.essentials_js).to have_text('£3,399.16')
  expect(step_three.total_leftover_js).to have_text('51%')
  expect(step_three.total_leftover_js).to have_text('£3,600.84')
  expect(step_three.remaining_js).to have_text('£2,700.84')
  expect(step_three.what_if_changes_js).to have_text('3%')
  expect(step_three.what_if_changes_js).to have_text('£2,542.99')
  expect(step_three.what_if_remaining_js).to have_text('£2,057.01')

  step_three.interest_rate_slider.set(3)
end

# Only runs as a javascript test
Then(/^I should be able to tweak the results by adjusting the interest rate slider$/) do
  expect(step_three).to have_interest_rate_slider

  step_three.interest_rate_slider.set(4)

  expect(step_three.repayments_js).to have_text('£1,899.16')
  expect(step_three.risk_chart_js).to have_text('49%')
  expect(step_three.essentials_js).to have_text('49%')
  expect(step_three.essentials_js).to have_text('£3,399.16')
  expect(step_three.total_leftover_js).to have_text('51%')
  expect(step_three.total_leftover_js).to have_text('£3,600.84')
  expect(step_three.remaining_js).to have_text('£2,700.84')
  expect(step_three.what_if_changes_js).to have_text('3%')
  expect(step_three.what_if_changes_js).to have_text('£2,542.99')
  expect(step_three.what_if_remaining_js).to have_text('£2,057.01')

  step_three.interest_rate_slider.set(3)
end

# Only runs as a javascript test
Then(/^I should be able to tweak the results by adjusting the mortgage term text$/) do
  expect(step_three).to have_term_years

  step_three.term_years.set(26)

  expect(step_three.repayments_js).to have_text('£2,279.97')
  expect(step_three.risk_chart_js).to have_text('54%')
  expect(step_three.essentials_js).to have_text('54%')
  expect(step_three.essentials_js).to have_text('£3,779.97')
  expect(step_three.total_leftover_js).to have_text('46%')
  expect(step_three.total_leftover_js).to have_text('£3,220.03')
  expect(step_three.remaining_js).to have_text('£2,320.03')
  expect(step_three.what_if_changes_js).to have_text('3%')
  expect(step_three.what_if_changes_js).to have_text('£2,988.94')
  expect(step_three.what_if_remaining_js).to have_text('£1,611.06')

  step_three.term_years.set(25)
end

# Only runs as a javascript test
Then(/^I should be able to tweak the results by adjusting the mortgage term slider$/) do
  expect(step_three).to have_term_years_slider

  step_three.term_years_slider.set(26)

  expect(step_three.repayments_js).to have_text('£2,279.97')
  expect(step_three.risk_chart_js).to have_text('54%')
  expect(step_three.essentials_js).to have_text('54%')
  expect(step_three.essentials_js).to have_text('£3,779.97')
  expect(step_three.total_leftover_js).to have_text('46%')
  expect(step_three.total_leftover_js).to have_text('£3,220.03')
  expect(step_three.remaining_js).to have_text('£2,320.03')
  expect(step_three.what_if_changes_js).to have_text('3%')
  expect(step_three.what_if_changes_js).to have_text('£2,988.94')
  expect(step_three.what_if_remaining_js).to have_text('£1,611.06')

  step_three.term_years.set(25)
end

Then(/^I should see the repayment term tooltip$/) do
  expect(step_three).to have_term_years_tip
end

When("I enter all details for single applicant at medium risk") do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "7000"
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
end

When("I enter all details for single applicant at low risk") do
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "7000"
  step_one.next.click
  step_two.next.click
end

When("I enter all details for single applicant at high risk") do
  step_one.annual_income.set "15000"
  step_one.monthly_net_income.set "1000"
  step_one.next.click
  step_two.credit_repayments.set "200"
  step_two.utilities.set "200"
  step_two.childcare.set "200"
  step_two.next.click
end

When("I visit the next steps page") do
  step_three.next_steps.click
end

When("I visit the next steps page without completing the tool") do
  next_steps.load
end

Then("I should see the medium risk next steps") do
  expect(page).to have_content(I18n::t("affordability.next_steps.medium.title"))
end

Then("I should see the low risk next steps") do
  expect(page).to have_content(I18n::t("affordability.next_steps.low.title"))
end

Then("I should see the high risk next steps") do
  expect(page).to have_content(I18n::t("affordability.next_steps.high.title"))
end

Then("I should see the default next steps") do
  expect(page).to have_content(I18n::t("affordability.next_steps.default.title"))
end
