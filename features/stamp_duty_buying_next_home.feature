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
  | 185000  | 0       |
  | 275000  | 1,250   |
  | 300019  | 2,500   |
  | 310000  | 3,000   |
  | 400012  | 7,500   |
  | 490000  | 12,000  |
  | 510000  | 13,000  |
  | 937000  | 34,950  |
  | 988882  | 40,138  |
  | 2100000 | 163,250 |

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
  | 185000  | 0       |
  | 275000  | 1,250   |
  | 300019  | 2,500   |
  | 310000  | 3,000   |
  | 400012  | 7,500   |
  | 490000  | 12,000  |
  | 510000  | 13,000  |
  | 937000  | 34,950  |
  | 988882  | 40,138  |
  | 2100000 | 163,250 |


Scenario: I recalculate for next home
  When I enter a house price of 550000
  And I am a next home buyer
  And I click next
  And I see the stamp duty I will have to pay is "£15,000"
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
