Feature: Stamp Duty - Next Home Buyer
So that I know how much stamp duty to pay
As a user buying my next home
I want to enter my house price

Background:
  Given I visit the Stamp Duty page

Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I am a next time buyer
  And I click next
  Then I see the title for the results page
  And I see the stamp duty I will have to pay is "£<duty>"
  And I see the effective tax rate is "<effective tax>"

Examples:
  | price   | duty   | effective tax |
  | 39000   | 0      | 0.00%         |
  | 40000   | 0      | 0.00%         |
  | 120000  | 0      | 0.00%         |
  | 126000  | 20     | 0.02%         |
  | 260000  | 3,000  | 1.15%         |
  | 350000  | 7,500  | 2.14%         |
  | 450000  | 12,500 | 2.78%         |
  | 550000  | 17,500 | 3.18%         |

@javascript
Scenario Outline: stamp duty for next home
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
  When I enter a house price of 260000
  And I am a next time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"

@javascript
Scenario: I recalculate for next home
  When I enter a house price of 260000
  And I am a next time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£3,000"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£20"