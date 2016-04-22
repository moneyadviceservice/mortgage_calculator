# encoding: UTF-8

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
  expect(@stamp_duty).to have_content(I18n.t('stamp_duty.h1'))
end

Then(/^they do not see the result output$/) do
  expect(@stamp_duty).to_not have_results
end

When(/^I enter my house price with "(.*?)"$/) do |amount|
  @stamp_duty.property_price.set amount
end

When(/^I click next$/) do
  @stamp_duty.next.click
end

When(/^I select to calculate for a second home$/) do
  @stamp_duty.second_home.set true
end

Then(/^I reenter my house price with "(.*?)"$/) do |amount|
  @stamp_duty.property_price_step_two.set amount
end

When(/^I click next again$/) do
  @stamp_duty.recalculate.click if js_disabled?
end

Then(/^they see "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

When(/^I enter my house price$/) do
  @stamp_duty.property_price.set "300000"
  @stamp_duty.next.click
end

Then(/^I see the stamp duty I will have to pay is "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

And(/^I see that the stamp duty cost falls into a band of "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

When(/^I go to next steps$/) do
  @stamp_duty.next_steps.click
end

Then(/^I see the Welsh stamp duty calculator$/) do
  expect(@stamp_duty.h1).to have_content('Cyfrifiannell treth stamp')
end
