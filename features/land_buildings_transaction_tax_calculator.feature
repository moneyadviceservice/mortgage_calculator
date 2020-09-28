Feature: Land and Buildings Transaction Tax Calculator
  As a user
  I want to enter my house price
  So that I know how much land and buildings transaction tax to pay

  Background:
    Given I visit the land and buildings transaction tax page

  Scenario Outline: taxes for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

  Examples:
    | price  | duty   | effective tax |
    | 39000  | 0      | 0.00%         |
    | 40000  | 0      | 0.00%         |
    | 120000 | 0      | 0.00%         |
    | 260000 | 500    | 0.19%         |
    | 300019 | 2,500  | 0.83%         |
    | 350000 | 6,250  | 1.79%         |
    | 450000 | 16,250 | 3.61%         |
    | 550000 | 26,250 | 4.77%         |
    | 901000 | 64,370 | 7.14%         |

  @javascript
  Scenario Outline: tax for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"

  Examples:
    | price  | duty   | effective tax |
    | 39000  | 0      | 0.00%         |
    | 40000  | 0      | 0.00%         |
    | 120000 | 0      | 0.00%         |
    | 260000 | 500    | 0.19%         |
    | 300019 | 2,500  | 0.83%         |
    | 350000 | 6,250  | 1.79%         |
    | 450000 | 16,250 | 3.61%         |
    | 550000 | 26,250 | 4.77%         |
    | 901000 | 64,370 | 7.14%         |

  Scenario: I recalculate for next home
    When I enter a house price of 280000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£1,500"
    Then I reenter my house price with "426000"
    And I click next again
    And I see the stamp duty I will have to pay is "£13,850"
    And I see the effective tax rate is "3.25%"

  @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 280000
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£1,500"
    Then I reenter my house price with "426000"
    And I click next again
    And I see the stamp duty I will have to pay is "£13,850"

  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I should see the tax rate being used is "<tax_rate>%"

    Examples:
      | price   | duty    | tax_rate |
      | 35000   | 0       | 0.00     |
      | 40000   | 1,600   | 4.00     |
      | 125000  | 5,000   | 4.00     |
      | 350000  | 20,250  | 5.79     |
      | 750000  | 76,250  | 10.17    |
      | 1223300 | 151,978 | 12.42    |

  @javascript
  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I should see the tax rate being used is "<tax_rate>%"

    Examples:
      | price   | duty    | tax_rate |
      | 35000   | 0       | 0.00     |
      | 40000   | 1,600   | 4.00     |
      | 125000  | 5,000   | 4.00     |
      | 350000  | 20,250  | 5.79     |
      | 750000  | 76,250  | 10.17    |
      | 1223300 | 151,978 | 12.42    |
