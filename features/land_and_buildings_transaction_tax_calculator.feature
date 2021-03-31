Feature: Land and Buildings Transaction Tax Calculator
  As a user
  I want to enter my house price
  So that I know how much land and buildings transaction tax to pay

  Background:
    Given I visit the land and buildings transaction tax page

  Scenario Outline: taxes for next home
    When I enter a house price of <price>
    And I enter a completion date
    And I am a next home buyer
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I see the effective tax rate is "<effective tax>"

  Examples:
    | price   | duty    | effective tax |
    | 39000   | 0       | 0.00%         |
    | 40000   | 0       | 0.00%         |
    | 120000  | 0       | 0.00%         |
    | 260000  | 2,600   | 1.00%         |
    | 300019  | 4,600   | 1.53%         |
    | 350000  | 8,350   | 2.39%         |
    | 450000  | 18,350  | 4.08%         |
    | 550000  | 28,350  | 5.15%         |
    | 901000  | 66,470  | 7.38%         |

  @javascript
  Scenario Outline: tax for next home
    When I enter a house price of <price>
    And I am a next home buyer
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"

  Examples:
    | price   | duty    | effective tax |
    | 39000   | 0       | 0.00%         |
    | 40000   | 0       | 0.00%         |
    | 120000  | 0       | 0.00%         |
    | 260000  | 2,600   | 1.00%         |
    | 300019  | 4,600   | 1.53%         |
    | 350000  | 8,350   | 2.39%         |
    | 450000  | 18,350  | 4.08%         |
    | 550000  | 28,350  | 5.15%         |
    | 901000  | 66,470  | 7.38%         |

  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I enter a completion date
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£2,600"
    Then I reenter my house price with "450000"
    And I click next again
    And I see the stamp duty I will have to pay is "£18,350"
    And I see the effective tax rate is "4.08%"

  @javascript
  Scenario: I recalculate for next home
    When I enter a house price of 260000
    And I enter a completion date
    And I am a next home buyer
    And I click next
    And I see the stamp duty I will have to pay is "£2,600"
    Then I reenter my house price with "450000"
    And I click next again
    And I see the stamp duty I will have to pay is "£18,350"

  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I enter a completion date
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I should see the tax rate being used is "<effective tax>%"

    Examples:
      | price   | duty    | effective tax |
      | 35000   | 0       | 0.00          |
      | 40000   | 1,600   | 4.00          |
      | 120000  | 4,800   | 4.00          |
      | 175000  | 7,600   | 4.34          |
      | 201000  | 9,160   | 4.56          |
      | 250000  | 12,100  | 4.84          |
      | 300000  | 16,600  | 5.53          |
      | 325000  | 18,850  | 5.80          |
      | 400000  | 29,350  | 7.34          |
      | 743000  | 77,370  | 10.41         |
      | 750000  | 78,350  | 10.45         |
      | 1200000 | 150,350 | 12.53         |

  @javascript
  Scenario Outline: Buy to let buyer
    Given I am buying an additional property or second home
    When I enter a house price of <price>
    And I enter a completion date
    And I click next
    Then I see the call out box with everything I need to know
    And I see the stamp duty I will have to pay is "£<duty>"
    And I should see the tax rate being used is "<effective tax>%"

    Examples:
      | price   | duty    | effective tax |
      | 35000   | 0       | 0.00          |
      | 40000   | 1,600   | 4.00          |
      | 120000  | 4,800   | 4.00          |
      | 175000  | 7,600   | 4.34          |
      | 201000  | 9,160   | 4.56          |
      | 250000  | 12,100  | 4.84          |
      | 300000  | 16,600  | 5.53          |
      | 325000  | 18,850  | 5.80          |
      | 400000  | 29,350  | 7.34          |
      | 743000  | 77,370  | 10.41         |
      | 750000  | 78,350  | 10.45         |
      | 1200000 | 150,350 | 12.53         |
