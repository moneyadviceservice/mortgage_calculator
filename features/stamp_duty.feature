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

@javascript
Scenario: When javascript is enabled
  Given I visit the Stamp Duty page
  When  I enter my house price
  Then  I see how much stamp duty I will have to pay
  And  I see which band the stamp duty cost falls into

Scenario: House price which is less than £125,000
  Given I visit the Stamp Duty page
  When I enter my house price with "120000"
  Then I see the stamp duty I will have to pay is "£0"

Scenario: House price which is over £125,000
  Given I visit the Stamp Duty page
  When I enter my house price with "126000"
  Then I see the stamp duty I will have to pay is "£20"

Scenario: House price which is over £250,000
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  Then I see the stamp duty I will have to pay is "£3,000"

Scenario: House price which is over £500,000
  Given I visit the Stamp Duty page
  When I enter my house price with "510000"
  Then I see the stamp duty I will have to pay is "£15,500"

Scenario: House price which is over £1 million
  Given I visit the Stamp Duty page
  When I enter my house price with "1100000"
  Then I see the stamp duty I will have to pay is "£53,750"

Scenario: House price which is over £2 million
  Given I visit the Stamp Duty page
  When I enter my house price with "2100000"
  Then I see the stamp duty I will have to pay is "£165,750"

@wip
Scenario: User enters invalid property price
  Given I visit the Stamp Duty page
  When I enter my house price with "sx"
  Then they do not see the result output

@wip
Scenario: User enters 0 as the property price
  Given I visit the Stamp Duty page
  When I enter my house price with "0"
  Then they do not see the result output
