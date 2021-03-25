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
  | price   | duty   | completion date |
  | 39000   | 0      | 2021-4-21       |
  | 40000   | 0      | 2021-4-21       |
  | 125000  | 0      | 2021-4-21       |
  | 185000  | 0      | 2021-4-21       |
  | 275000  | 0      | 2021-4-21       |
  | 300019  | 0      | 2021-4-21       |
  | 310000  | 0      | 2021-4-21       |
  | 400012  | 0      | 2021-4-21       |
  | 490000  | 0      | 2021-4-21       |
  | 510000  | 500    | 2021-4-21       |
  | 937000  | 22450  | 2021-4-21       |
  | 988882  | 27638  | 2021-4-21       |
  | 2100000 | 150750 | 2021-4-21       |
  | 39000   | 0      | 2021-7-21       |
  | 40000   | 0      | 2021-7-21       |
  | 125000  | 0      | 2021-7-21       |
  | 185000  | 0      | 2021-7-21       |
  | 275000  | 1250   | 2021-7-21       |
  | 300019  | 2500   | 2021-7-21       |
  | 310000  | 3000   | 2021-7-21       |
  | 400012  | 7500   | 2021-7-21       |
  | 490000  | 12000  | 2021-7-21       |
  | 510000  | 13000  | 2021-7-21       |
  | 937000  | 34950  | 2021-7-21       |
  | 988882  | 40138  | 2021-7-21       |
  | 2100000 | 163250 | 2021-7-21       |
  | 39000   | 0      | 2021-10-21      |
  | 40000   | 0      | 2021-10-21      |
  | 125000  | 0      | 2021-10-21      |
  | 185000  | 1200   | 2021-10-21      |
  | 275000  | 3750   | 2021-10-21      |
  | 300019  | 5000   | 2021-10-21      |
  | 310000  | 5500   | 2021-10-21      |
  | 400012  | 10000  | 2021-10-21      |
  | 490000  | 14500  | 2021-10-21      |
  | 510000  | 15500  | 2021-10-21      |
  | 937000  | 37450  | 2021-10-21      |
  | 988882  | 42638  | 2021-10-21      |
  | 2100000 | 165750 | 2021-10-21      |

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
  | 125000  | 0      | 2021-4-21       |
  | 185000  | 0      | 2021-4-21       |
  | 275000  | 0      | 2021-4-21       |
  | 300019  | 0      | 2021-4-21       |
  | 310000  | 0      | 2021-4-21       |
  | 400012  | 0      | 2021-4-21       |
  | 490000  | 0      | 2021-4-21       |
  | 510000  | 500    | 2021-4-21       |
  | 937000  | 22450  | 2021-4-21       |
  | 988882  | 27638  | 2021-4-21       |
  | 2100000 | 150750 | 2021-4-21       |
  | 39000   | 0      | 2021-7-21       |
  | 40000   | 0      | 2021-7-21       |
  | 125000  | 0      | 2021-7-21       |
  | 185000  | 0      | 2021-7-21       |
  | 275000  | 1250   | 2021-7-21       |
  | 300019  | 2500   | 2021-7-21       |
  | 310000  | 3000   | 2021-7-21       |
  | 400012  | 7500   | 2021-7-21       |
  | 490000  | 12000  | 2021-7-21       |
  | 510000  | 13000  | 2021-7-21       |
  | 937000  | 34950  | 2021-7-21       |
  | 988882  | 40138  | 2021-7-21       |
  | 2100000 | 163250 | 2021-7-21       |
  | 39000   | 0      | 2021-10-21      |
  | 40000   | 0      | 2021-10-21      |
  | 125000  | 0      | 2021-10-21      |
  | 185000  | 1200   | 2021-10-21      |
  | 275000  | 3750   | 2021-10-21      |
  | 300019  | 5000   | 2021-10-21      |
  | 310000  | 5500   | 2021-10-21      |
  | 400012  | 10000  | 2021-10-21      |
  | 490000  | 14500  | 2021-10-21      |
  | 510000  | 15500  | 2021-10-21      |
  | 937000  | 37450  | 2021-10-21      |
  | 988882  | 42638  | 2021-10-21      |
  | 2100000 | 165750 | 2021-10-21      |

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
