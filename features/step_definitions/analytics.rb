Then(/^My repayment completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click"})
end

Then(/^My stamp duty completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Stamp Duty Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click"})
end

When(/^I refine my details$/) do
  @repayment.step_two_price.set "200000"
  @repayment.step_two_price.set "300000"
  @repayment.step_two_price.set "400000"
  @repayment.step_two_deposit.set "20000"

  @repayment.term_years.set "30"
  @repayment.interest_rate.set "4"
end

Then(/^My repayment refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Price"})
end

Then(/^My stamp duty next steps interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Stamp Duty Calculator", "eventAction"=>"Next Steps", "eventLabel"=>"Click"})
end

Then(/^My repayment next steps interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Next Steps", "eventLabel"=>"Click"})

end

Then(/^My affordability completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click"})
end

Then(/^My affordability borrowing refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Borrowing"})
end

Then(/^My affordability interest rate refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Interest Rate"})
end

Then(/^My affordability lifestyle refinement interaction is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Lifestyle"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My risk level is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Risk Level", "eventLabel"=>"medium"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Remaining", "eventLabel"=>"Non-positive"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is not tracked$/) do
    expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Remaining", "eventLabel"=>"Non-positive"}
  expect(page).to_not have_analytics_event(expected)
end
