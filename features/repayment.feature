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

Scenario: When viewing the tool
  Given I visit the Repayment calculator
  Then  I can enter the price
  And   I can enter the deposit

