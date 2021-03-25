Feature: Stamp Duty - Second House Buyer
So that I know how much stamp duty to pay
As a user buying a second house
I want to enter my house price

@javascript
Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    | completion date |
  | 39000   | 0       | 2021-4-21       |
  | 40000   | 1,200   | 2021-4-21       |
  | 120000  | 3,600   | 2021-4-21       |
  | 126000  | 3,780   | 2021-4-21       |
  | 260000  | 7,800   | 2021-4-21       |
  | 510000  | 15,800  | 2021-4-21       |
  | 988882  | 57,304  | 2021-4-21       |
  | 1100000 | 71,750  | 2021-4-21       |
  | 2100000 | 213,750 | 2021-4-21       |
  | 450000  | 13,500  | 2021-4-21       |
  | 500000  | 15,000  | 2021-4-21       |
  | 577888  | 21,231  | 2021-4-21       |
  | 1440000 | 115,950 | 2021-4-21       |

Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    | completion date |
  | 39000   | 0       | 2021-4-21       |
  | 40000   | 1,200   | 2021-4-21       |
  | 120000  | 3,600   | 2021-4-21       |
  | 126000  | 3,780   | 2021-4-21       |
  | 260000  | 7,800   | 2021-4-21       |
  | 510000  | 15,800  | 2021-4-21       |
  | 988882  | 57,304  | 2021-4-21       |
  | 1100000 | 71,750  | 2021-4-21       |
  | 2100000 | 213,750 | 2021-4-21       |
  | 450000  | 13,500  | 2021-4-21       |
  | 500000  | 15,000  | 2021-4-21       |
  | 577888  | 21,231  | 2021-4-21       |
  | 1440000 | 115,950 | 2021-4-21       |

Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£7,800"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,780"

@javascript
Scenario: I recalculate for second home
  Given I visit the Stamp Duty page
  When I enter my house price with "260000"
  And I select to calculate for a second home
  And I click next
  And I see the stamp duty I will have to pay is "£7,800"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£3,780"
