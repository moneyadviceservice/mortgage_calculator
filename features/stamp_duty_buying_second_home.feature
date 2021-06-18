Feature: Stamp Duty - Second House Buyer
So that I know how much stamp duty to pay
As a user buying a second house
I want to enter my house price

@javascript
Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  And the date is "2021-04-01"
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty       | completion date |
  | 39000   | 0          | 2021-4-21       |
  | 40000   | 1,200      | 2021-4-21       |
  | 125000  | 3,750      | 2021-4-21       |
  | 185000  | 5,550      | 2021-4-21       |
  | 275000  | 8,250      | 2021-4-21       |
  | 300019  | 9,000      | 2021-4-21       |
  | 310000  | 9,300      | 2021-4-21       |
  | 400012  | 12,000     | 2021-4-21       |
  | 490000  | 14,700     | 2021-4-21       |
  | 510000  | 15,800     | 2021-4-21       |
  | 937000  | 50,560     | 2021-4-21       |
  | 988882  | 57,304     | 2021-4-21       |
  | 2100000 | 213,750    | 2021-4-21       |
  | 39000   | 0          | 2021-7-21       |
  | 40000   | 1,200      | 2021-7-21       |
  | 125000  | 3,750      | 2021-7-21       |
  | 185000  | 5,550      | 2021-7-21       |
  | 275000  | 9,500      | 2021-7-21       |
  | 300019  | 11,501     | 2021-7-21       |
  | 310000  | 12,300     | 2021-7-21       |
  | 400012  | 19,500     | 2021-7-21       |
  | 490000  | 26,700     | 2021-7-21       |
  | 510000  | 28,300     | 2021-7-21       |
  | 937000  | 63,060     | 2021-7-21       |
  | 988882  | 69,804     | 2021-7-21       |
  | 2100000 | 226,250    | 2021-7-21       |
  | 39000   | 0          | 2021-10-21      |
  | 40000   | 1,200      | 2021-10-21      |
  | 125000  | 3,750      | 2021-10-21      |
  | 185000  | 6,750      | 2021-10-21      |
  | 275000  | 12,000     | 2021-10-21      |
  | 300019  | 14,001     | 2021-10-21      |
  | 310000  | 14,800     | 2021-10-21      |
  | 400012  | 22,000     | 2021-10-21      |
  | 490000  | 29,200     | 2021-10-21      |
  | 510000  | 30,800     | 2021-10-21      |
  | 937000  | 65,560     | 2021-10-21      |
  | 988882  | 72,304     | 2021-10-21      |
  | 2100000 | 228,750    | 2021-10-21      |

Scenario Outline: stamp duty for second home
  Given I visit the Stamp Duty page
  And the date is "2021-04-01"
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I select to calculate for a second home
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty       | completion date |
  | 39000   | 0          | 2021-4-21       |
  | 40000   | 1,200      | 2021-4-21       |
  | 125000  | 3,750      | 2021-4-21       |
  | 185000  | 5,550      | 2021-4-21       |
  | 275000  | 8,250      | 2021-4-21       |
  | 300019  | 9,000      | 2021-4-21       |
  | 310000  | 9,300      | 2021-4-21       |
  | 400012  | 12,000     | 2021-4-21       |
  | 490000  | 14,700     | 2021-4-21       |
  | 510000  | 15,800     | 2021-4-21       |
  | 937000  | 50,560     | 2021-4-21       |
  | 988882  | 57,304     | 2021-4-21       |
  | 2100000 | 213,750    | 2021-4-21       |
  | 39000   | 0          | 2021-7-21       |
  | 40000   | 1,200      | 2021-7-21       |
  | 125000  | 3,750      | 2021-7-21       |
  | 185000  | 5,550      | 2021-7-21       |
  | 275000  | 9,500      | 2021-7-21       |
  | 300019  | 11,501     | 2021-7-21       |
  | 310000  | 12,300     | 2021-7-21       |
  | 400012  | 19,500     | 2021-7-21       |
  | 490000  | 26,700     | 2021-7-21       |
  | 510000  | 28,300     | 2021-7-21       |
  | 937000  | 63,060     | 2021-7-21       |
  | 988882  | 69,804     | 2021-7-21       |
  | 2100000 | 226,250    | 2021-7-21       |
  | 39000   | 0          | 2021-10-21      |
  | 40000   | 1,200      | 2021-10-21      |
  | 125000  | 3,750      | 2021-10-21      |
  | 185000  | 6,750      | 2021-10-21      |
  | 275000  | 12,000     | 2021-10-21      |
  | 300019  | 14,001     | 2021-10-21      |
  | 310000  | 14,800     | 2021-10-21      |
  | 400012  | 22,000     | 2021-10-21      |
  | 490000  | 29,200     | 2021-10-21      |
  | 510000  | 30,800     | 2021-10-21      |
  | 937000  | 65,560     | 2021-10-21      |
  | 988882  | 72,304     | 2021-10-21      |
  | 2100000 | 228,750    | 2021-10-21      |

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
