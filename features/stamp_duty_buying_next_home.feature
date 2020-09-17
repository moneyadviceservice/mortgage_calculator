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
  And I see the effective tax rate is "<effective tax>"

Examples:
  | price   | duty    | effective tax |
  | 39000   | 0       | 0.00%         |
  | 40000   | 0       | 0.00%         |
  | 120000  | 0       | 0.00%         |
  | 126000  | 0       | 0.00%         |
  | 260000  | 0       | 0.00%         |
  | 300019  | 0       | 0.00%         |
  | 350000  | 0       | 0.00%         |
  | 450000  | 0       | 0.00%         |
  | 550000  | 2,500   | 0.45%         |
  | 650000  | 7,500   | 1.15%         |

@javascript
Scenario Outline: stamp duty for next home
  When I enter a house price of <price>
  And I am a next home buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty   |
  | 39000   | 0      |
  | 40000   | 0      |
  | 120000  | 0      |
  | 126000  | 0      |
  | 260000  | 0      |
  | 350000  | 0      |
  | 400012  | 0      |
  | 450000  | 0      |
  | 550000  | 2,500  |
  | 750000  | 12,500 |
  | 1500000 | 78,750 |

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
