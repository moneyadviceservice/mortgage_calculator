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

@javascript
Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    |
  | 39000   | 0       |
  | 40000   | 0       |
  | 120000  | 0       |
  | 126000  | 0       |
  | 260000  | 0       |
  | 350000  | 2,500   |
  | 450000  | 7,500   |
  | 550000  | 17,500  |

@javascript
Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    |
  | 39000   | 0       |
  | 40000   | 1,200   |
  | 120000  | 3,600   |
  | 126000  | 3,800   |
  | 260000  | 10,800  |
  | 510000  | 30,800  |
  | 1100000 | 86,750  |
  | 2100000 | 228,750 |

Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"

@javascript
Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£10,800"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,800"

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
