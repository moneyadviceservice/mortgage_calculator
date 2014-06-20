Then(/^I should (not )?see the stamp duty feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_falsey
  else
    page.has_link?("Feedback").should be_truthy
  end
end

Then(/^I should (not )?see the affordability feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_falsey
  else
    page.has_link?("Feedback").should be_truthy
  end
end

Then(/^I should (not )?see the repayment feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_falsey
  else
    page.has_link?("Feedback").should be_truthy
  end
end

