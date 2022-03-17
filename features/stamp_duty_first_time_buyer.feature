Feature: Stamp Duty - First Time Buyer
So that I know how much stamp duty to pay
As a user buying my first home
I want to enter my house price

Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty     |
  | 39000   | 0        |
  | 40000   | 0        |
  | 125000  | 0        |
  | 185000  | 0        |
  | 275000  | 0        |
  | 300019  | 0        |
  | 310000  | 500      |
  | 400012  | 5,000    |
  | 490000  | 9,500    |
  | 510000  | 15,500   |
  | 937000  | 37,450   |
  | 988882  | 42,638   |
  | 2100000 | 165,750  |

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
  When I enter my house price with "350000"
  And I am a first time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"
