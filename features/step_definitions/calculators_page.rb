Given /^a user visits the Affordability page$/ do
  visit '/en/mortgage_calculator/affordability'
end

Then /^they should see the Affordability calculator$/ do
  expect(page).to have_content('Find out how much you can borrow')
end

When(/^they fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, :with => value
end

Then(/^they see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

When(/^they select (\d+) people$/) do |number|
  select(number, from: 'numberOfPeople')
end

