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
    | 260000  | 500        | 0.19%         |
    | 333333  | 4,166      | 1.25%         |
    | 467895  | 12,592     | 2.69%         |
    | 800000  | 38,750     | 4.84%         |
    | 2000000 | 168,750    | 8.44%         |

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
    | 260000  | 500        | 0.19%         |
    | 333333  | 4,166      | 1.25%         |
    | 467895  | 12,592     | 2.69%         |
    | 800000  | 38,750     | 4.84%         |
    | 2000000 | 168,750    | 8.44%         |

  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£500"
    Then I reenter my house price with "426000"
    And I click next again
    And I see the stamp duty I will have to pay is "£9,450"
    And I see the effective tax rate is "2.22%"

  @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£500"
    Then I reenter my house price with "333333"
    And I click next again
    And I see the stamp duty I will have to pay is "£4,166.65"

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

  @javascript
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
