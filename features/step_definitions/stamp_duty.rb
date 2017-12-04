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

Then(/^I reenter my house price with "(.*?)"$/) do |amount|
  @stamp_duty.property_price_step_two.set amount
end

When(/^I click next again$/) do
  @stamp_duty.recalculate.click if js_disabled?
end

Then(/^they see "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

And(/^I am a first time buyer$/) do
  @stamp_duty.select('a first-time buyer', from: @buyer_type)
end

And(/^I select to calculate for a second home$/) do
  @stamp_duty.select('buying an additional or buy-to-let property', from: @buyer_type)
end

When(/^I enter my house price$/) do
  @stamp_duty.property_price.set "300000"
  @stamp_duty.next.trigger('click')
end

Then(/^I see the stamp duty I will have to pay is "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

And(/^I see that the stamp duty cost falls into a band of "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end

Then(/^I see the Welsh stamp duty calculator$/) do
  expect(@stamp_duty.h1.first).to have_content('Cyfrifiannell treth stamp')
end

Then(/^I should see the stamp duty percentages for first time buyers as:$/) do |table|
  data = table.raw
  headings = data[0]
  expect(headings).to eq ["Purchase Price of property", "Rate of Stamp Duty", "Buy to Let/Additional Home Rate*"]
  expect(data[1]).to eq ["£0 - £125,000", "0%", "3%"]
  expect(data[2]).to eq ["£125,001 - £250,000", "2%", "5%"]
  expect(data[3]).to eq ["£250,001 - £925,000", "3%", "8%"]
  expect(data[4]).to eq ["£925,001 - £1,500,000", "10%", "13%"]
  expect(data[5]).to eq ["over £1.5 million", "12%", "15%"]
end
