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
  | 185000  | 5,550      |
  | 275000  | 9,500      |
  | 300019  | 11,501     |
  | 310000  | 12,300     |
  | 400012  | 19,500     |
  | 490000  | 26,700     |
  | 510000  | 28,300     |
  | 937000  | 63,060     |
  | 988882  | 69,804     |
  | 2100000 | 226,250    |

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
  | 185000  | 5,550      |
  | 275000  | 9,500      |
  | 300019  | 11,501     |
  | 310000  | 12,300     |
  | 400012  | 19,500     |
  | 490000  | 26,700     |
  | 510000  | 28,300     |
  | 937000  | 63,060     |
  | 988882  | 69,804     |
  | 2100000 | 226,250    |

Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£8,300"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,780"

@javascript
Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£8,300"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,780"
