Given(/^I visit the Repayment calculator$/) do
  @repayment = UI::Pages::Repayment.new
  @repayment.load
end

Then(/^I can enter the price$/) do
  expect(@repayment).to have_price
end

Then(/^I can enter the deposit$/) do
  expect(@repayment).to have_deposit
end
