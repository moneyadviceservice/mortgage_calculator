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
    | price   | duty       | effective tax | completion date |
    | 190000  | 0          | 0.00%         | 2021-7-21       |
    | 260000  | 2,100      | 0.81%         | 2021-7-21       |
    | 333333  | 6,499.98   | 1.95%         | 2021-7-21       |
    | 467895  | 15,592.13  | 3.33%         | 2021-7-21       |
    | 800000  | 41,750     | 5.22%         | 2021-7-21       |
    | 2000000 | 171,750    | 8.59%         | 2021-7-21       |

  @javascript
  Scenario Outline: tax for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    Then I see the stamp duty I will have to pay is "£<duty>"

  Examples:
    | price   | duty       | effective tax | completion date |
    | 190000  | 0          | 0.00%         | 2021-7-21       |
    | 260000  | 2,100      | 0.81%         | 2021-7-21       |
    | 333333  | 6,499.98   | 1.95%         | 2021-7-21       |
    | 467895  | 15,592.13  | 3.33%         | 2021-7-21       |
    | 800000  | 41,750     | 5.22%         | 2021-7-21       |
    | 2000000 | 171,750    | 8.59%         | 2021-7-21       |

  Scenario: I recalculate for next home
    When I enter a house price of 275000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£3,000"
    Then I reenter my house price with "490000"
    And I click next again
    And I see the stamp duty I will have to pay is "£17,250"
    And I see the effective tax rate is "3.52%"

  @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 275000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£3,000"
    Then I reenter my house price with "490000"
    And I click next again
    And I see the stamp duty I will have to pay is "£17,250"

  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
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
