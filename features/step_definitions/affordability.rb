Given /^I visit the Affordability page$/ do
  @affordability = UI::Pages::Affordability.new
  @affordability.load
end

Given(/^I visit the Syndicated Affordability page$/) do
  @affordability = UI::Pages::SyndicatedAffordability.new
  @affordability.load
end

Then /^I should see the Affordability title$/ do
  expect(@affordability.h2).to have_content(I18n.t("affordability.title"))
end

Then(/^I see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

When(/^I submit the details$/) do
  @affordability.nexts.first.click
end

Given(/^I submit the first step$/) do
  @affordability.step_1_next.click
end

When(/^I submit invalid details$/) do
  @affordability.monthly_net_income.set "asd"
  @affordability.step_1_next.click
end

Then(/^I see an error message$/) do
  expect(page).to have_content('Monthly net income is not a number')
end

Then(/^I do not see the result output$/) do
  expect(@affordability).to_not have_results
end

When(/^I enter all details for "(.*?)" applicants$/) do |applicant|
  @affordability.annual_income.set "100000"
  @affordability.extra_income.set "10000"
  @affordability.monthly_net_income.set "6000"

  if applicant.to_i == 2
    choose('two_applicants') unless js_disabled?
    @affordability.person_two_annual_income.set "50000"
    @affordability.person_two_extra_income.set "5000"
    @affordability.person_two_monthly_net_income.set "3000"
  end

  @affordability.step_1_next.click

  @affordability.credit_repayments.set "300"
  @affordability.utilities.set "300"
  @affordability.childcare.set "300"
  @affordability.child_maintenance.set "300"
  @affordability.rent_and_mortgage.set "300"
  @affordability.food.set "300"
  @affordability.travel.set "300"
  @affordability.entertainment.set "300"
  @affordability.holiday.set "300"

  @affordability.step_2_next.click
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
  @affordability.interest_rate.set "10"
end

When(/^I recalculate$/) do
  @affordability.recalculate.click
end

Given(/^I enter (\w+) (\d+\.?\d*)$/) do |field, input|
  @affordability.public_send(field).set input
end

Given(/^I click on second applicant$/) do
  check('two_applicants') unless js_disabled?
end

