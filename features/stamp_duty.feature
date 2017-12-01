Feature: Stamp Duty Calculator
So that I know how much stamp duty to pay
As a user
I want to enter my house price

Scenario: Can view the Stamp Duty Calculator
  Given I visit the Stamp Duty page
  Then they should see the Stamp Duty calculator

Scenario: Welsh users
  Given I visit the Welsh Stamp Duty page
  Then  I see the Welsh stamp duty calculator

@wip
Scenario: User enters invalid property price
  Given I visit the Stamp Duty page
  When I enter my house price with "sx"
  And I click next
  Then they do not see the result output

@wip
Scenario: User enters 0 as the property price
  Given I visit the Stamp Duty page
  When I enter my house price with "0"
  And I click next
  Then they do not see the result output
