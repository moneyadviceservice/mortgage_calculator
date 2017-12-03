Feature: Stamp Duty Information Table
In order to understand how my stamp duty is calculated
As a first time buyer
I want to see what percentages apply to the purchase price

Scenario: First time buyer
  Given I visit the Stamp Duty page
  And I select 'isFTB' as my buyer type
  Then I should see the stamp duty percentages for first time buyers

Scenario: Next home buyer
  Given I visit the Stamp Duty page
  And I select 'isNextHome' as my buyer type
  Then I should not see the stamp duty percentages for first time buyers

Scenario: Second home buyer
  Given I visit the Stamp Duty page
  And I select 'isSecondHome' as my buyer type
  Then I should not see the stamp duty percentages for first time buyers