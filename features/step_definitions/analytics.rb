Then(/^My repayment completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click", "tool_name"=>"mortg_calc"})
end

Then(/^My stamp duty completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Stamp Duty Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click", "tool_name"=>"stamp_calc"})
end

When(/^I refine my details$/) do
  @repayment.step_two_price.set "200000"
  @repayment.step_two_price.set "300000"
  @repayment.step_two_price.set "400000"
  @repayment.step_two_deposit.set "20000"

  @repayment.term_years.set "30"
  @repayment.interest_rate.set "3"
end

Then(/^My repayment refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Price", "tool_name"=>"mortg_calc"})
end

Then(/^My stamp duty next steps interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Stamp Duty Calculator", "eventAction"=>"Next Steps", "eventLabel"=>"Click", "tool_name"=>"stamp_calc"})
end

Then(/^My repayment next steps interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Mortgage Calculator", "eventAction"=>"Next Steps", "eventLabel"=>"Click", "tool_name"=>"mortg_calc"})

end

Then(/^My affordability completion interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Completion", "eventLabel"=>"Click", "tool_name"=>"afford_calc"})
end

Then(/^My affordability borrowing refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Borrowing", "tool_name"=>"afford_calc"})
end

Then(/^My affordability interest rate refinement interaction is tracked$/) do
  expect(page).to have_analytics_event({"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Interest Rate", "tool_name"=>"afford_calc"})
end

Then(/^My affordability lifestyle refinement interaction is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Refinement", "eventLabel"=>"Lifestyle", "tool_name"=>"afford_calc"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My risk level is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Risk Level", "eventLabel"=>"high", "tool_name"=>"afford_calc"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is tracked$/) do
  expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Remaining", "eventLabel"=>"Non-positive", "tool_name"=>"afford_calc"}
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is not tracked$/) do
    expected = {"event"=>"GAEvent", "eventCategory"=>"Affordability Calculator", "eventAction"=>"Remaining", "eventLabel"=>"Non-positive", "tool_name"=>"afford_calc"}
  expect(page).to_not have_analytics_event(expected)
end
