Feature: Stamp Duty Calculator
So that I know how much stamp duty to pay
As a user
I want to enter my house price

Scenario: When javascript is enabled
  Given I visit the Stamp Duty page
  When  I enter my house price
  Then  I see how much stamp duty I will have to pay


