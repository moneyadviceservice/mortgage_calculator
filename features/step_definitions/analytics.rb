Then(/^My repayment completion interaction is tracked$/) do
  if js_enabled?
    expected = ['_trackEvent','Mortgage Calculator','Completion','Click']
    gaq = page.evaluate_script('window._gaq')
    expect(gaq).to include(expected)
  else
    expected = "['_trackEvent','Mortgage Calculator','Completion','Click']"
    expect(page.html).to have_content(expected)
  end
end

Then(/^My stamp duty completion interaction is tracked$/) do
  expected = ['_trackEvent','Stamp Duty Calculator','Completion','Click']
  gaq = page.evaluate_script('window._gaq')
  expect(gaq).to include(expected)
end

When(/^I refine my details$/) do
  @repayment.step_two_price.set "200000"
  @repayment.step_two_deposit.set "20000"

  @repayment.term_years.set "30"
  @repayment.interest_rate.set "3"
end

Then(/^My repayment refinement interaction is tracked$/) do
  expected = ['_trackEvent','Mortgage Calculator','Refinement','Price']
  gaq = page.evaluate_script('window._gaq')
  expect(gaq).to include(expected)
end

Then(/^My stamp duty next steps interaction is tracked$/) do
  expected = ['_trackEvent','Stamp Duty Calculator','Next Steps','Click']
  gaq = page.evaluate_script('window._gaq')
  expect(gaq).to include(expected)
end

Then(/^My repayment next steps interaction is tracked$/) do
  expected = ['_trackEvent','Mortgage Calculator','Next Steps','Click']
  gaq = page.evaluate_script('window._gaq')
  expect(gaq).to include(expected)
end

