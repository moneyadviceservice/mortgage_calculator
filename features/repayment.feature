Feature: Mortgage Repayment Calculator
So that I know how much my montly mortgage repayments will be and understand the relationship between them
As a homebuyer
I want to enter my property price, deposit size and product interest rate

@wip
Scenario: When viewing the tool for the first time
  Given I visit the Repayment calculator
  Then  I see the MAS global header
  And   I see the title
  And   I see some descriptive blurb
  And   I see the repayment url

@javascript
Scenario: When using the tool for the first time
  Given I visit the Repayment calculator
  When  I enter my repayment house price
  And   I enter my deposit
  Then  I see my monthly repayment

Scenario: When using the tool for the first time
  Given I visit the Repayment calculator
  When  I enter my repayment house price
  And   I enter my deposit
  Then  I see my monthly repayment

@javascript
Scenario: When updating values in the tool
  Given I have entered some details into the repayment tool
  When  I update my repayment details
  Then  I see my updated monthly repayment

Scenario: When updating values in the tool
  Given I have entered some details into the repayment tool
  When  I update my repayment details
  Then  I see my updated monthly repayment

