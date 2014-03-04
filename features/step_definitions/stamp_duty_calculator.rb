# encoding: UTF-8

Given(/^I visit the Stamp Duty page$/) do
  visit '/en/mortgage_calculator/stamp_duty'
end

When(/^I enter my house price$/) do
  fill_in "stamp_duty[price]", :with => "300000"
  find("input[type=submit]").click
end

Then(/^I see how much stamp duty I will have to pay$/) do
  expect(page).to have_content("Based on your total purchase price of £300,000.00 you will have to pay 3% in stamp duty, costing £9,000.00. Bringing your total spend to £309,000.00")
end
