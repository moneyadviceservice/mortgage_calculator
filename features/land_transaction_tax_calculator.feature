Feature: Land Transaction Tax Calculator
  As a user
  I want to enter my house price
  So that I know how much land transaction tax to pay

  Background:
    Given I visit the land transaction tax page

  Scenario Outline: taxes for next home
    When I enter a house price of <price>
    And I enter a completion date of <completion date>
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

  Examples:
    | price   | duty       | effective tax | completion date |
    | 39000   | 0          | 0.00%         | 2021-7-21       |
    | 40000   | 0          | 0.00%         | 2021-7-21       |
    | 179000  | 0          | 0.00%         | 2021-7-21       |
    | 190000  | 350        | 0.18%         | 2021-7-21       |
    | 260000  | 2,950      | 1.13%         | 2021-7-21       |
    | 333333  | 6,616.65   | 1.98%         | 2021-7-21       |
    | 467895  | 15,042.13  | 3.21%         | 2021-7-21       |
    | 800000  | 41,200     | 5.15%         | 2021-7-21       |
    | 2000000 | 171,200    | 8.56%         | 2021-7-21       |
    | 39000   | 0          | 0%            | 2021-4-21       |
    | 40000   | 0          | 0%            | 2021-4-21       |
    | 145000  | 0          | 0%            | 2021-4-21       |
    | 185000  | 0          | 0%            | 2021-4-21       |
    | 275000  | 1,250      | 0.45%         | 2021-4-21       |
    | 300000  | 2,500      | 0.83%         | 2021-4-21       |
    | 490000  | 14,250     | 2.91%         | 2021-4-21       |
    | 510000  | 15,750     | 3.09%         | 2021-4-21       |
    | 937500  | 52,500     | 5.60%         | 2021-4-21       |
    | 2100000 | 180,750    | 8.61%         | 2021-4-21       |


  @wip @javascript
  Scenario Outline: tax for next home
    When I enter a house price of <price>
    And I enter a completion date of <completion date>
    And I am a next home buyer
    And I click next
    Then I see the stamp duty I will have to pay is "£<duty>"

  Examples:
    | price   | duty       | effective tax | completion date |
    | 39000   | 0          | 0.00%         | 2021-7-21       |
    | 40000   | 0          | 0.00%         | 2021-7-21       |
    | 179000  | 0          | 0.00%         | 2021-7-21       |
    | 190000  | 350        | 0.18%         | 2021-7-21       |
    | 260000  | 2,950      | 1.13%         | 2021-7-21       |
    | 333333  | 6,616.65   | 1.98%         | 2021-7-21       |
    | 467895  | 15,042.13  | 3.21%         | 2021-7-21       |
    | 800000  | 41,200     | 5.15%         | 2021-7-21       |
    | 2000000 | 171,200    | 8.56%         | 2021-7-21       |
    | 39000   | 0          | 0%            | 2021-4-21       |
    | 40000   | 0          | 0%            | 2021-4-21       |
    | 145000  | 0          | 0%            | 2021-4-21       |
    | 185000  | 0          | 0%            | 2021-4-21       |
    | 275000  | 1,250      | 0.45%         | 2021-4-21       |
    | 300000  | 2,500      | 0.83%         | 2021-4-21       |
    | 490000  | 14,250     | 2.91%         | 2021-4-21       |
    | 510000  | 15,750     | 3.09%         | 2021-4-21       |
    | 937500  | 52,500     | 5.60%         | 2021-4-21       |
    | 2100000 | 180,750    | 8.61%         | 2021-4-21       |

  Scenario: I recalculate for next home
    When I enter a house price of 275000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£1,250"
    Then I reenter my house price with "490000"
    And I click next again
    And I see the stamp duty I will have to pay is "£14,250"
    And I see the effective tax rate is "2.91%"

  @wip @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 275000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£1,250"
    Then I reenter my house price with "490000"
    And I click next again
    And I see the stamp duty I will have to pay is "£14,250"

  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I enter a completion date
    And I click next
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

    Examples:
      | price   | duty     | effective tax |
      | 35000   | 0        | 0.00%         |
      | 135588  | 5,423.52 | 4.00%         |
      | 180000  | 7,200    | 4.00%         |
      | 260000  | 13,350   | 5.13%         |
      | 500000  | 37,450   | 7.49%         |
      | 900000  | 87,200   | 9.69%         |
      | 1800000 | 219,200  | 12.18%        |

  @wip @javascript
  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I enter a completion date
    And I click next
    And I see the stamp duty I will have to pay is "£<duty>"

    Examples:
      | price   | duty     | effective tax |
      | 35000   | 0        | 0.00%         |
      | 135588  | 5,423.52 | 4.00%         |
      | 180000  | 7,200    | 4.00%         |
      | 260000  | 13,350   | 5.13%         |
      | 500000  | 37,450   | 7.49%         |
      | 900000  | 87,200   | 9.69%         |
      | 1800000 | 219,200  | 12.18%        |
