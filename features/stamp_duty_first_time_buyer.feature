Feature: Stamp Duty - First Time Buyer
So that I know how much stamp duty to pay
As a user buying my first home
I want to enter my house price

Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty     | completion date |
  | 39000   | 0        | 2021-4-21       |
  | 40000   | 0        | 2021-4-21       |
  | 125000  | 0        | 2021-4-21       |
  | 185000  | 0        | 2021-4-21       |
  | 275000  | 0        | 2021-4-21       |
  | 300019  | 0        | 2021-4-21       |
  | 310000  | 0        | 2021-4-21       |
  | 400012  | 0        | 2021-4-21       |
  | 490000  | 0        | 2021-4-21       |
  | 510000  | 500      | 2021-4-21       |
  | 937000  | 22,450   | 2021-4-21       |
  | 988882  | 27,638   | 2021-4-21       |
  | 2100000 | 150,750  | 2021-4-21       |
  | 39000   | 0        | 2021-7-21       |
  | 40000   | 0        | 2021-7-21       |
  | 125000  | 0        | 2021-7-21       |
  | 185000  | 0        | 2021-7-21       |
  | 275000  | 0        | 2021-7-21       |
  | 300019  | 0        | 2021-7-21       |
  | 310000  | 500      | 2021-7-21       |
  | 400012  | 5,000    | 2021-7-21       |
  | 490000  | 9,500    | 2021-7-21       |
  | 510000  | 13,000   | 2021-7-21       |
  | 937000  | 34,950   | 2021-7-21       |
  | 988882  | 40,138   | 2021-7-21       |
  | 2100000 | 163,250  | 2021-7-21       |
  | 39000   | 0        | 2021-10-21      |
  | 40000   | 0        | 2021-10-21      |
  | 125000  | 0        | 2021-10-21      |
  | 185000  | 0        | 2021-10-21      |
  | 275000  | 0        | 2021-10-21      |
  | 300019  | 0        | 2021-10-21      |
  | 310000  | 500      | 2021-10-21      |
  | 400012  | 5,000    | 2021-10-21      |
  | 490000  | 9,500    | 2021-10-21      |
  | 510000  | 15,500   | 2021-10-21      |
  | 937000  | 37,450   | 2021-10-21      |
  | 988882  | 42,638   | 2021-10-21      |
  | 2100000 | 165,750  | 2021-10-21      |

@javascript
Scenario Outline: stamp duty for first home
  Given I visit the Stamp Duty page
  When I enter a house price of <price>
  And I enter a completion date of <completion date>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price   | duty    | completion date |
  | 39000   | 0       | 2021-4-21       |
  | 40000   | 0       | 2021-4-21       |
  | 120000  | 0       | 2021-4-21       |
  | 126000  | 0       | 2021-4-21       |
  | 260000  | 0       | 2021-4-21       |
  | 350000  | 0       | 2021-4-21       |
  | 400012  | 0       | 2021-4-21       |
  | 450000  | 0       | 2021-4-21       |
  | 550000  | 2,500   | 2021-4-21       |
  | 750000  | 12,500  | 2021-4-21       |
  | 1500000 | 78,750  | 2021-4-21       |

Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "350000"
  And I enter a completion date
  And I am a first time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"

@wip @javascript
Scenario: I recalculate for first home
  Given I visit the Stamp Duty page
  When I enter my house price with "550000"
  And I enter a completion date
  And I am a first time buyer
  And I click next
  And I see the stamp duty I will have to pay is "£2,500"
  Then I reenter my house price with "126000"
  And I click next again
  And I see the stamp duty I will have to pay is "£0"
