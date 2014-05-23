Feature: Stamp Duty Calculator Feedback
So that I can make MAS better
As a user
I want to be able to give feedback

Scenario: When entering house price
  Given I visit the Stamp Duty page
  Then  I should see the stamp duty feedback tab

Scenario: When using syndicated stamp duty calculator
  Given I visit the Syndicated Stamp Duty page
  Then  I should not see the stamp duty feedback tab

