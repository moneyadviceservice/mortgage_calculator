# encoding: UTF-8

Given /^I visit the Stamp Duty page$/ do
  @stamp_duty = UI::Pages::StampDuty.new
  @stamp_duty.load
end

Then /^they should see the Stamp Duty calculator$/ do
  expect(@stamp_duty.h1).to have_content('How much will the stamp duty be for this property?')
end

Then(/^they do not see the result output$/) do
  expect(@stamp_duty).to_not have_results
end

When(/^they enter the cost of a property with "(.*?)"$/) do |amount|
  @stamp_duty.property_price.set amount
end

Then(/^they see "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

When(/^I enter my house price$/) do
  @stamp_duty.property_price.set "300000"
  @stamp_duty.submit.click
end

Then(/^I see how much stamp duty I will have to pay$/) do
  expect(@stamp_duty).to have_content("Based on your total purchase price of £300,000.00 you will have to pay 3% in stamp duty, costing £9,000.00. Bringing your total spend to £309,000.00")
end

