@javascript
Feature: Google analytics
  So that we can improve MAS
  As a MAS minion
  We want to measure the activity of our users

Scenario: When a user uses the mortgage calculator
  Given I visit the Repayment calculator
  When  I have entered some details into the repayment tool
  Then  My repayment completion interaction is tracked

Scenario: When a user uses the mortgage calculator
  Given I visit the Repayment calculator
  When  I have entered some details into the repayment tool
  And   I go to mortgage calculator next steps
  Then  My repayment next steps interaction is tracked

Scenario: When a user uses the stamp duty calculator
  Given I visit the stamp duty calculator
  When  I enter my house price
  Then  My stamp duty completion interaction is tracked

Scenario: When a user uses the mortgage calculator
  Given I visit the Repayment calculator
  When  I have entered some details into the repayment tool
  And   I refine my details
  Then  My repayment refinement interaction is tracked

Scenario: When a user uses the stamp duty calculator
  Given I visit the stamp duty calculator
  When  I enter my house price
  And   I go to next steps
  Then  My stamp duty next steps interaction is tracked

Scenario: When a user uses completes the affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  Then  My affordability completion interaction is tracked

Scenario: When a user refines affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  And  I refine my affordability borrowing
  Then  My affordability borrowing refinement interaction is tracked

Scenario: When a user refines affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  And  I refine my affordability interest rate
  Then  My affordability interest rate refinement interaction is tracked

Scenario: When a user refines affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  And  I refine my affordability interest rate slider
  Then  My affordability interest rate refinement interaction is tracked

Scenario: When a user refines affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  And  I refine my affordability lifestyle
  Then  My affordability lifestyle refinement interaction is tracked

Scenario: When a user refines affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  And   I refine my affordability lifestyle slider
  Then  My affordability lifestyle refinement interaction is tracked

Scenario: When a user uses affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  Then  My risk level is tracked

Scenario: When a user uses affordability calculator
  Given I visit the Affordability calculator
  When  I enter details giving negative remaining amount
  Then  My negative remainging is tracked

Scenario: When a user uses affordability calculator
  Given I visit the Affordability calculator
  When  I enter all details for single applicant
  Then  My negative remainging is not tracked
