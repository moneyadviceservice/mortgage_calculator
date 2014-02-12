
Given /^a user visits the home page$/ do
  visit 'en/mortgage_calculator'
end

Then /^they should see the affordability calculator$/ do
  expect(page).to have_content('Affordability')
end
