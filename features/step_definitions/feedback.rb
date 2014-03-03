Then(/^I should see the stamp duty feedback tab$/) do
  page.has_link?("https://mastest.zendesk.com/account/dropboxes/20289328").should be_true
end
