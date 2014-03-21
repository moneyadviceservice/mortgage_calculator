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

