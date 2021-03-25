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
  | price   | duty      | completion date |
  | 39000   | 0         | 2021-4-21       |
  | 40000   | 1200      | 2021-4-21       |
  | 125000  | 3750      | 2021-4-21       |
  | 185000  | 5550      | 2021-4-21       |
  | 275000  | 8250      | 2021-4-21       |
  | 300019  | 9000      | 2021-4-21       |
  | 310000  | 9300      | 2021-4-21       |
  | 400012  | 12000     | 2021-4-21       |
  | 490000  | 14700     | 2021-4-21       |
  | 510000  | 15800     | 2021-4-21       |
  | 937000  | 50560     | 2021-4-21       |
  | 988882  | 57304     | 2021-4-21       |
  | 2100000 | 213750    | 2021-4-21       |
  | 39000   | 0         | 2021-7-21       |
  | 40000   | 1200      | 2021-7-21       |
  | 125000  | 3750      | 2021-7-21       |
  | 185000  | 5550      | 2021-7-21       |
  | 275000  | 9500      | 2021-7-21       |
  | 300019  | 11501     | 2021-7-21       |
  | 310000  | 12300     | 2021-7-21       |
  | 400012  | 19500     | 2021-7-21       |
  | 490000  | 26700     | 2021-7-21       |
  | 510000  | 28300     | 2021-7-21       |
  | 937000  | 63060     | 2021-7-21       |
  | 988882  | 69804     | 2021-7-21       |
  | 2100000 | 226250    | 2021-7-21       |
  | 39000   | 0         | 2021-10-21      |
  | 40000   | 1200      | 2021-10-21      |
  | 125000  | 3750      | 2021-10-21      |
  | 185000  | 6750      | 2021-10-21      |
  | 275000  | 12000     | 2021-10-21      |
  | 300019  | 14001     | 2021-10-21      |
  | 310000  | 14800     | 2021-10-21      |
  | 400012  | 22000     | 2021-10-21      |
  | 490000  | 29200     | 2021-10-21      |
  | 510000  | 30800     | 2021-10-21      |
  | 937000  | 65560     | 2021-10-21      |
  | 988882  | 72304     | 2021-10-21      |
  | 2100000 | 228750    | 2021-10-21      |

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
  | 39000   | 0         | 2021-4-21       |
  | 40000   | 1200      | 2021-4-21       |
  | 125000  | 3750      | 2021-4-21       |
  | 185000  | 5550      | 2021-4-21       |
  | 275000  | 8250      | 2021-4-21       |
  | 300019  | 9000      | 2021-4-21       |
  | 310000  | 9300      | 2021-4-21       |
  | 400012  | 12000     | 2021-4-21       |
  | 490000  | 14700     | 2021-4-21       |
  | 510000  | 15800     | 2021-4-21       |
  | 937000  | 50560     | 2021-4-21       |
  | 988882  | 57304     | 2021-4-21       |
  | 2100000 | 213750    | 2021-4-21       |
  | 39000   | 0         | 2021-7-21       |
  | 40000   | 1200      | 2021-7-21       |
  | 125000  | 3750      | 2021-7-21       |
  | 185000  | 5550      | 2021-7-21       |
  | 275000  | 9500      | 2021-7-21       |
  | 300019  | 11501     | 2021-7-21       |
  | 310000  | 12300     | 2021-7-21       |
  | 400012  | 19500     | 2021-7-21       |
  | 490000  | 26700     | 2021-7-21       |
  | 510000  | 28300     | 2021-7-21       |
  | 937000  | 63060     | 2021-7-21       |
  | 988882  | 69804     | 2021-7-21       |
  | 2100000 | 226250    | 2021-7-21       |
  | 39000   | 0         | 2021-10-21      |
  | 40000   | 1200      | 2021-10-21      |
  | 125000  | 3750      | 2021-10-21      |
  | 185000  | 6750      | 2021-10-21      |
  | 275000  | 12000     | 2021-10-21      |
  | 300019  | 14001     | 2021-10-21      |
  | 310000  | 14800     | 2021-10-21      |
  | 400012  | 22000     | 2021-10-21      |
  | 490000  | 29200     | 2021-10-21      |
  | 510000  | 30800     | 2021-10-21      |
  | 937000  | 65560     | 2021-10-21      |
  | 988882  | 72304     | 2021-10-21      |
  | 2100000 | 228750    | 2021-10-21      |

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
