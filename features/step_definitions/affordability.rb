Given /^I visit the Affordability (?:page|calculator)$/i do
  step_one.load
end

Given(/^I visit the Welsh Affordability page$/) do
  @affordability = UI::Pages::Affordability::WelshAffordability.new
  @affordability.load
end

Then(/^I see the Welsh Affordability calculator$/) do
  expect(page).to have_content("welsh title")
end

Given(/^I visit the Syndicated Affordability page$/) do
  @affordability = UI::Pages::Affordability::SyndicatedAffordability.new
  @affordability.load
end

Then /^I should see the Affordability title$/ do
  expect(step_one.h2).to have_content(I18n.t("affordability.title"))
end

Then(/^I see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

When(/^I submit the details$/) do
  @affordability.nexts.first.click
end

Given(/^I submit the first step$/) do
  step_one.next.click
end

When(/^I submit invalid details$/) do
  step_one.monthly_net_income.set "asd"
  step_one.next.click
end

Then(/^I see an error message$/) do
  expect(page).to have_content(I18n.t("affordability.activemodel.errors.messages.not_a_number", attribute: ''))
end

Then(/^I do not see the result output$/) do
  expect(@affordability).to_not have_results
end

When(/^I enter all details for "(.*?)" applicants$/) do |applicant|
  step_one.annual_income.set "100000"
  step_one.extra_income.set "10000"
  step_one.monthly_net_income.set "6000"

  if applicant.to_i == 2
    choose('affordability[two_applicants]')
    step_one.person_two_annual_income.set "50000"
    step_one.person_two_extra_income.set "5000"
    step_one.person_two_monthly_net_income.set "3000"
  end

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

When(/^I enter some details for applicant "(.*?)"$/) do |applicant|
  if applicant.to_i == 1
    fill_in "affordability[people_attributes][0][annual_income]", :with => "100000"
  elsif applicant.to_i == 2
    fill_in "affordability[people_attributes][1][annual_income]", :with => "50000"
  end
end

Given(/^I have entered all details for applicant "(.*?)"$/) do |applicants|
  step "I visit the Affordability page"
  step "I enter all details for \"#{applicants.to_i}\" applicants"
end

When(/^I update my affordability circumstances$/) do
  step_three.interest_rate.set "10"
end

When(/^I recalculate$/) do
  step_three.recalculate.click
end

Given(/^I enter (\w+\.\w+) (\d+\.?\d*)$/) do |field, input|
  # don't judge me, this is tempoary until the next PR
  eval(" #{field}.set #{input}")
end

Given(/^I click on second applicant$/) do
  check('affordability[two_applicants]')
end

When(/^I refine my affordability borrowing$/) do
  step_three.borrowing_slider.set(300000)
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

Given(/^I submit step one$/) do
  step_one.next.click
end

Given(/^I submit step two$/) do
  step_two.next.click
end
