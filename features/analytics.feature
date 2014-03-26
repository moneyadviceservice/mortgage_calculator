Feature: Google analytics
  So that we can improve MAS
  As a MAS minion
  We want to measure the activity of our users

Scenario: When a user uses the mortgage calculator
  Given I visit the Repayment calculator
  When  I have entered some details into the repayment tool
  Then  My repayment completion interaction is tracked

# @javascript
# Scenario: When a user uses the mortgage calculator
#   Given I visit the Repayment calculator
#   When  I have entered some details into the repayment tool
#   Then  My repayment completion interaction is tracked

# @javascript
# Scenario: When a user uses the mortgage calculator
#   Given I visit the Repayment calculator
#   When  I have entered some details into the repayment tool
#   And   I refine my details
#   Then  My repayment refinement interaction is tracked
