Feature: Stamp Duty - Next Home Buyer
So that I know how much stamp duty to pay
As a user buying my next home
I want to enter my house price

Scenario Outline: stamp duty for next home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I am a next time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty   |
  | 39000   | 0      |
  | 40000   | 0      |
  | 120000  | 0      |
  | 126000  | 20     |
  | 260000  | 3,000  |
  | 350000  | 7,500  |
  | 450000  | 12,500 |
  | 550000  | 17,500 |

@javascript
Scenario Outline: stamp duty for next home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I am a next time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty   |
  | 39000   | 0      |
  | 40000   | 0      |
  | 120000  | 0      |
  | 126000  | 20     |
  | 260000  | 3,000  |
  | 350000  | 7,500  |
  | 450000  | 12,500 |
  | 550000  | 17,500 |


Scenario: I recalculate for next home
  Given I visit the Stamp Duty page
  When I enter a house price of 260000
  And I am a next time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"

@javascript
Scenario: I recalculate for next home
  Given I visit the Stamp Duty page
  When I enter a house price of 260000
  And I am a next time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"