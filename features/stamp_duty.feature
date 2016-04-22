@with_and_without_javascript
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

Scenario: House price which is less than £40,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "39000"
  And I click next
  Then I see the stamp duty I will have to pay is "£0"

Scenario: House price which is less than £40,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "39000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£0"

Scenario: House price which is equal to £40,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "40000"
  And I click next
  Then I see the stamp duty I will have to pay is "£0"

Scenario: House price which is equal to £40,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "40000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£1,200"

Scenario: House price which is less than £125,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "120000"
  And I click next
  Then I see the stamp duty I will have to pay is "£0"

Scenario: House price which is less than £125,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "120000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£3,600"

Scenario: House price which is over £125,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "126000"
  And I click next
  Then I see the stamp duty I will have to pay is "£20"

Scenario: House price which is over £125,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "126000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "3,800"

Scenario: House price which is over £250,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I click next
  Then I see the stamp duty I will have to pay is "£3,000"

Scenario: House price which is over £250,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£10,800"

Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"

Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£10,800"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,800"

Scenario: I recalculate for first home after calculating for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£10,800"
  Then I reenter my house price with "126000"
  And I unselect to calculate for a second home
  And I click next again
  And I see the stamp duty I will have to pay is "£20"

Scenario: I recalculate for second home after calculating for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I select this time to calculate for a second home
  And I click next again
  And I see the stamp duty I will have to pay is "£3,800"

Scenario: House price which is over £500,000 for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "510000"
  And I click next
  Then I see the stamp duty I will have to pay is "£15,500"

Scenario: House price which is over £500,000 for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "510000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£30,800"

Scenario: House price which is over £1 million for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "1100000"
  And I click next
  Then I see the stamp duty I will have to pay is "£53,750"

Scenario: House price which is over £1 million for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "1100000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£86,750"

Scenario: House price which is over £2 million for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "2100000"
  And I click next
  Then I see the stamp duty I will have to pay is "£165,750"

Scenario: House price which is over £2 million for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "2100000"
  And I select to calculate for a second home
  And I click next
  Then I see the stamp duty I will have to pay is "£228,750"

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
