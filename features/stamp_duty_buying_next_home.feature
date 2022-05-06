Feature: Stamp Duty - Next Home Buyer
So that I know how much stamp duty to pay
As a user buying my next home
I want to enter my house price

Background:
  Given I visit the Stamp Duty page

Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I am a next home buyer
  And I click next
  Then I see the title for the results page
  And I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    |
  | 39000   | 0       |
  | 40000   | 0       |
  | 125000  | 0       |
  | 185000  | 1,200   |
  | 275000  | 3,750   |
  | 300019  | 5,000   |
  | 310000  | 5,500   |
  | 400012  | 10,000  |
  | 490000  | 14,500  |
  | 510000  | 15,500  |
  | 937000  | 37,450  |
  | 988882  | 42,638  |
  | 2100000 | 165,750 |

@javascript
Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I am a next home buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    |
  | 39000   | 0       |
  | 40000   | 0       |
  | 125000  | 0       |
  | 185000  | 1,200   |
  | 275000  | 3,750   |
  | 300019  | 5,000   |
  | 310000  | 5,500   |
  | 400012  | 10,000  |
  | 490000  | 14,500  |
  | 510000  | 15,500  |
  | 937000  | 37,450  |
  | 988882  | 42,638  |
  | 2100000 | 165,750 |


Scenario: I recalculate for next home
  When I enter a house price of 550000
  And I am a next home buyer
  And I click next
  And I see the stamp duty I will have to pay is "£17,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"

@wip @javascript
Scenario: I recalculate for next home
  When I enter a house price of 550000
  And I am a next home buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"
