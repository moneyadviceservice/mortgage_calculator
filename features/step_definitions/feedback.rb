Then(/^I should (not )?see the stamp duty feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_false
  else
    page.has_link?("Feedback").should be_true
  end
end

Then(/^I should (not )?see the affordability feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_false
  else
    page.has_link?("Feedback").should be_true
  end
end

Then(/^I should (not )?see the repayment feedback tab$/) do |negated|
  if negated
    page.has_link?("Feedback").should be_false
  else
    page.has_link?("Feedback").should be_true
  end
end

