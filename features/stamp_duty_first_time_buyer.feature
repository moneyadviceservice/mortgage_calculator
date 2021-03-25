Feature: Stamp Duty - First Time Buyer
So that I know how much stamp duty to pay
As a user buying my first home
I want to enter my house price

Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    | completion date |
  | 39000   | 0       | 2021-4-21       |
  | 40000   | 0       | 2021-4-21       |
  | 120000  | 0       | 2021-4-21       |
  | 126000  | 0       | 2021-4-21       |
  | 260000  | 0       | 2021-4-21       |
  | 350000  | 0       | 2021-4-21       |
  | 400012  | 0       | 2021-4-21       |
  | 450000  | 0       | 2021-4-21       |
  | 550000  | 2,500   | 2021-4-21       |
  | 750000  | 12,500  | 2021-4-21       |
  | 1500000 | 78,750  | 2021-4-21       |

@javascript
Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    | completion date |
  | 39000   | 0       | 2021-4-21       |
  | 40000   | 0       | 2021-4-21       |
  | 120000  | 0       | 2021-4-21       |
  | 126000  | 0       | 2021-4-21       |
  | 260000  | 0       | 2021-4-21       |
  | 350000  | 0       | 2021-4-21       |
  | 400012  | 0       | 2021-4-21       |
  | 450000  | 0       | 2021-4-21       |
  | 550000  | 2,500   | 2021-4-21       |
  | 750000  | 12,500  | 2021-4-21       |
  | 1500000 | 78,750  | 2021-4-21       |

Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "350000"
  And I am a first time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"

@javascript
Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "550000"
  And I am a first time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"
