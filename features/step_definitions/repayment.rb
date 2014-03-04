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
  @repayment.submit.click
end

Then(/^I see my monthly repayment$/) do
  require 'pry'; binding.pry
  expect(@repayment).to have_content("£526.13")
end

