Given /^a user visits the Stamp Duty page$/ do
  @stamp_duty = UI::Pages::StampDuty.new
  @stamp_duty.load
end

Then /^they should see the Stamp Duty calculator$/ do
  expect(@stamp_duty.h1).to have_content('How much will the stamp duty be for this property?')
end

Then(/^they do not see the result output$/) do
  expect(@stamp_duty.has_results?).to be_false
end

When(/^they enter the cost of a property with "(.*?)"$/) do |amount|
  @stamp_duty.property_price.set amount
end

Then(/^they see "(.*?)"$/) do |content|
  expect(@stamp_duty).to have_content(content)
end
