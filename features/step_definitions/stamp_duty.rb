# encoding: UTF-8

Given("the date is {string}") do |date|
  travel_to date.to_date
end

Given /^I visit the( Welsh)? Stamp Duty (?:page|calculator)$/i do |welsh|
  welsh = (welsh =~ /welsh/i)

  @stamp_duty = UI::Pages::StampDuty.new
  @stamp_duty = UI::Pages::WelshStampDuty.new if welsh

  @stamp_duty.load
end

Given(/^I visit the Syndicated Stamp Duty page$/) do
  @stamp_duty = UI::Pages::SyndicatedStampDuty.new
  @stamp_duty.load
end

Then /^they should see the Stamp Duty calculator$/ do
  expect(@stamp_duty).to have_content(I18n.t('stamp_duty.heading'))
end

Then(/^they do not see the result output$/) do
  expect(@stamp_duty).to_not have_results
end

And(/^I enter my house price with "(.*?)"$/) do |amount|
  @stamp_duty.property_price.set amount
end

When(/^I enter a house price of (\d+)$/) do |amount|
  @stamp_duty.property_price.set amount
end

When(/^I click next$/) do
  @stamp_duty.next.click
end

Then(/^I see the title for the results page$/) do
  expect(@stamp_duty.h1.first).to have_content('Stamp Duty Calculator - Your Results')
end

Then("I see the title for the {string} results page") do |calculator|
  expect(@stamp_duty.h1.first).to have_content("#{calculator} calculator - Your Results")
end

Then(/^I reenter my house price with "(.*?)"$/) do |amount|
  @stamp_duty.property_price_step_two.set amount
end

When(/^I click next again$/) do
  @stamp_duty.recalculate.click
end

Then(/^they see "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

Given(/^I am a first time buyer$/) do
  @stamp_duty.buyer_type_select.select('a first-time buyer', from: @buyer_type)
end

Given(/^I am a next home buyer$/) do
  @stamp_duty.buyer_type_select.select('buying my next home', from: @buyer_type)
end

Given("I am an additional or buy-to-let property buyer") do
  @stamp_duty.buyer_type_select.select('buying an additional or buy-to-let property', from: @buyer_type)
end

Given("I am buying an additional property or second home") do
  @stamp_duty.buyer_type_select.select('buying an additional property or second home', from: @buyer_type)
end

And(/^I select to calculate for a second home$/) do
  @stamp_duty.buyer_type_select.select('buying an additional property or second home', from: @buyer_type)
end

When(/^I enter my house price$/) do
  step('I enter my house price with "300000"')
  step('I click next')
end

Then(/^I see the stamp duty I will have to pay is "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

Then(/^I should see the tax rate being used is "(.*?)"$/) do |tax_rate|
  expect(@stamp_duty.tax_due.first).to have_content(tax_rate)
end

And(/^I see that the stamp duty cost falls into a band of "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

Then(/^I see the Welsh stamp duty calculator$/) do
  expect(@stamp_duty.h1.first).to have_content('Cyfrifiannell treth stamp')
end

When("I reach the results page") do
  step('I enter my house price with "30000"')
  step('I click next')
end

Then("I should see the additional home buyer message") do
  expect(@stamp_duty).to have_next_home_explanation
end

Then(/^I should( NOT)? see the first time buyer message$/) do |should_not|
  if should_not
    expect(@stamp_duty).to_not have_ftb_explanation
  else
    expect(@stamp_duty).to have_ftb_explanation
  end
end

Then("I should see the stamp duty percentages table:") do |table|
  data = table.raw
  headings = data[0]
  expect(@stamp_duty.info_table).to have_content(headings.join(' '))
  expect(@stamp_duty.info_table).to have_content(data[1].join(' '))
  expect(@stamp_duty.info_table).to have_content(data[2].join(' '))
  expect(@stamp_duty.info_table).to have_content(data[3].join(' '))
  expect(@stamp_duty.info_table).to have_content(data[4].join(' '))
end

Then(/^I should( NOT)? see the first time eligibility message$/) do |should_not|
    if should_not
      expect(@stamp_duty).to_not have_ftb_conditional
    else
      expect(@stamp_duty).to have_ftb_conditional
    end
end

Then("I see the effective tax rate is {string}") do |string|
  expect(@stamp_duty.effective_tax).to have_content(string)
end
