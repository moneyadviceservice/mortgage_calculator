
Given /^a user visits the Affordability page$/ do
  visit 'en/mortgage_calculator/affordability'
end

Then /^they should see the Affordability calculator$/ do
  expect(page).to have_content('Find out how much you can borrow')
end
