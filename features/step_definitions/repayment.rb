# encoding: UTF-8

Given(/^I visit the Repayment calculator$/) do
  @repayment = UI::Pages::Repayment.new
  @repayment.load
end

Then(/^I enter my repayment house price$/) do
  @repayment.price.set "100000"
end

Then(/^I enter my deposit$/) do
  @repayment.deposit.set "10000"
  @repayment.next.click
end

Then(/^I see my monthly repayment$/) do
  expect(@repayment).to have_content("£526.13")
end

Given(/^I have entered some details into the repayment tool$/) do
  step "I visit the Repayment calculator"
  step "I enter my repayment house price"
  step "I enter my deposit"
  step "I see my monthly repayment"
end

When(/^I update my repayment details$/) do
  @repayment.step_two_price.set "90000"
  @repayment.step_two_deposit.set "20000"
  @repayment.term_years.set "30"
  @repayment.interest_rate.set "4"
  @repayment.recalculate.click
end

Then(/^I see my updated monthly repayment$/) do
  expect(@repayment).to have_content("£334.19")
end

