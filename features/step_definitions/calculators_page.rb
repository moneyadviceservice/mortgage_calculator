Given /^I visit the Affordability page$/ do
  visit '/en/mortgage_calculator/affordability'
end

Then /^I should see the Affordability calculator$/ do
  expect(page).to have_content('Find out how much you can borrow')
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, :with => value
end

Then(/^I see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

When(/^I select (\d+) people$/) do |number|
  select(number, from: 'numberOfPeople')
end

Then(/^I see "(.*?)" text inputs$/) do |count|
  all("input[type=text]").length.should == count.to_i
end

When(/^submit their details$/) do
  find("input[type=submit]").click
end

Then(/^I see "(.*?)" select dropdowns$/) do |count|
end

Then(/^I can change the number of applicants$/) do
  all("select").length.should == 1
end

Then(/^I can not change the number of applicants$/) do
  all("select").length.should == 0
end

When(/^I submit invalid details$/) do
  fill_in "affordability[people_attributes][0][annual_income]", :with => "one"
end

Then(/^I see an error message$/) do
  expect(page).to have_content('Please enter an amount')
end

When(/^I enter all details for applicant "(.*?)"$/) do |applicant|
  if applicant.to_i == 1
    fill_in "affordability[people_attributes][0][annual_income]", :with => "100000"
    fill_in "affordability[people_attributes][0][extra_income]", :with => "10000"
  elsif applicant.to_i == 2
    fill_in "affordability[people_attributes][1][annual_income]", :with => "50000"
    fill_in "affordability[people_attributes][1][extra_income]", :with => "5000"
  end
end

When(/^I enter their monthly debt$/) do
  fill_in "affordability[monthly_debt]", :with => "2000"
end

