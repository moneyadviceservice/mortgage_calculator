Given /^a user visits the Stamp Duty page$/ do
  visit '/en/mortgage_calculator/stamp_duty'
end

Then /^they should see the Stamp Duty calculator$/ do
  expect(page).to have_content('How much will the stamp duty be for this property?')
end

Then(/^they do not see the result output$/) do
  expect(page).not_to have_selector('p.results')
end

When(/^they enter the cost of a property with "(.*?)"$/) do |amount|
  fill_in "stamp_duty[price]", :with => amount
end

Then(/^they see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end
