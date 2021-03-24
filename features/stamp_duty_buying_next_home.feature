Feature: Stamp Duty - Next Home Buyer
So that I know how much stamp duty to pay
As a user buying my next home
I want to enter my house price

Background:
  Given I visit the Stamp Duty page

Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a next home buyer
  And I click next
  Then I see the title for the results page
  And I see the stamp duty I will have to pay is "£<duty>"
  And I see the effective tax rate is "<effective tax>"

Examples:
  | price   | duty    | effective tax | completion date |
  | 39000   | 0       | 0.00%         | 2021-4-21       |
  | 40000   | 0       | 0.00%         | 2021-4-21       |
  | 120000  | 0       | 0.00%         | 2021-4-21       |
  | 126000  | 0       | 0.00%         | 2021-4-21       |
  | 260000  | 0       | 0.00%         | 2021-4-21       |
  | 300019  | 0       | 0.00%         | 2021-4-21       |
  | 350000  | 0       | 0.00%         | 2021-4-21       |
  | 450000  | 0       | 0.00%         | 2021-4-21       |
  | 550000  | 2,500   | 0.45%         | 2021-4-21       |
  | 650000  | 7,500   | 1.15%         | 2021-4-21       |

@javascript
Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a next home buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty   | completion date |
  | 39000   | 0      | 2021-4-21       |
  | 40000   | 0      | 2021-4-21       |
  | 120000  | 0      | 2021-4-21       |
  | 126000  | 0      | 2021-4-21       |
  | 260000  | 0      | 2021-4-21       |
  | 350000  | 0      | 2021-4-21       |
  | 400012  | 0      | 2021-4-21       |
  | 450000  | 0      | 2021-4-21       |
  | 550000  | 2,500  | 2021-4-21       |
  | 750000  | 12,500 | 2021-4-21       |
  | 1500000 | 78,750 | 2021-4-21       |

Scenario: I recalculate for next home
  When I enter a house price of 550000
  And I am a next home buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"

@javascript
Scenario: I recalculate for next home
  When I enter a house price of 550000
  And I am a next home buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"
