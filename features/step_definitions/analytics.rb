Then(/^My repayment completion interaction is tracked$/) do
  expected = "['_trackEvent','Mortgage Calculator','Completion','Click']"
  expect(page.html).to have_content(expected)
end

