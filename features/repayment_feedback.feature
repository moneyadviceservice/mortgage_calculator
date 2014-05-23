Feature: Repayment Calculator Feedback
So that I can make MAS better
As a user
I want to be able to give feedback

Scenario: When entering house price
  Given I visit the Repayment calculator
  Then  I should see the repayment feedback tab

Scenario: When using syndicated repayment calculator
  Given I visit the Syndicated Repayment calculator
  Then  I should not see the repayment feedback tab

