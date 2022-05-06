Feature: Stamp Duty - Second House Buyer
So that I know how much stamp duty to pay
As a user buying a second house
I want to enter my house price

@javascript
Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty       |
  | 39000   | 0          |
  | 40000   | 1,200      |
  | 125000  | 3,750      |
  | 185000  | 6,750      |
  | 275000  | 12,000     |
  | 300019  | 14,001     |
  | 310000  | 14,800     |
  | 400012  | 22,000     |
  | 490000  | 29,200     |
  | 510000  | 30,800     |
  | 937000  | 65,560     |
  | 988882  | 72,304     |
  | 2100000 | 228,750    |

Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty       |
  | 39000   | 0          |
  | 40000   | 1,200      |
  | 125000  | 3,750      |
  | 185000  | 6,750      |
  | 275000  | 12,000     |
  | 300019  | 14,001     |
  | 310000  | 14,800     |
  | 400012  | 22,000     |
  | 490000  | 29,200     |
  | 510000  | 30,800     |
  | 937000  | 65,560     |
  | 988882  | 72,304     |
  | 2100000 | 228,750    |

Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£10,800"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,800"

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
