Then(/^I should see the stamp duty feedback tab$/) do
  page.has_link?("https://mastest.zendesk.com/account/dropboxes/20289328").should be_true
end

Then(/^I should see the affordability feedback tab$/) do
  page.has_link?("https://mastest.zendesk.com/account/dropboxes/20293976").should be_true
end

