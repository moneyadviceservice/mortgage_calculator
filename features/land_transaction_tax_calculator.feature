Feature: Land Transaction Tax Calculator
  As a user
  I want to enter my house price
  So that I know how much land transaction tax to pay

  Background:
    Given I visit the land transaction tax page

  Scenario Outline: taxes for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

  Examples:
    | price   | duty       | effective tax |
    | 39000   | 0          | 0.00%         |
    | 40000   | 0          | 0.00%         |
    | 179000  | 0          | 0.00%         |
    | 260000  | 2,950      | 1.13%         |
    | 333333  | 6,616.65   | 1.98%         |
    | 467895  | 15,042.13  | 3.21%         |
    | 800000  | 41,200     | 5.15%         |
    | 2000000 | 171,200    | 8.56%         |

  @javascript
  Scenario Outline: tax for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    Then I see the stamp duty I will have to pay is "£<duty>"

  Examples:
    | price   | duty       | effective tax |
    | 39000   | 0          | 0.00%         |
    | 40000   | 0          | 0.00%         |
    | 179000  | 0          | 0.00%         |
    | 260000  | 2,950      | 1.13%         |
    | 333333  | 6,616.65   | 1.98%         |
    | 467895  | 15,042.13  | 3.21%         |
    | 800000  | 41,200     | 5.15%         |
    | 2000000 | 171,200    | 8.56%         |

  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£2,950"
    Then I reenter my house price with "426000"
    And I click next again
    And I see the stamp duty I will have to pay is "£11,900"
    And I see the effective tax rate is "2.79%"

  @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£2,950.00"
    Then I reenter my house price with "333333"
    And I click next again
    And I see the stamp duty I will have to pay is "£6,616.65"

  Scenario Outline: Buy to let buyer
    Given I am an additional or buy-to-let property buyer
    When I enter a house price of <price>
    And I click next
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

    Examples:
      | price   | duty     | effective tax |
      | 35000   | 0        | 0.00%         |
      | 135588  | 4,067.64 | 3.00%         |
      | 180000  | 5,400    | 3.00%         |
      | 260000  | 10,750   | 4.13%         |
      | 500000  | 32,450   | 6.49%         |
      | 900000  | 78,200   | 8.69%         |
      | 1800000 | 201,200  | 11.18%        |
