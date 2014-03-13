Then(/^I should see the stamp duty feedback tab$/) do
  page.has_link?("Feedback").should be_true
end

Then(/^I should see the affordability feedback tab$/) do
  page.has_link?("Feedback").should be_true
end

Then(/^I should see the repayment feedback tab$/) do
  page.has_link?("Feedback").should be_true
end

