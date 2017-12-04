Feature: Stamp Duty Information Table
In order to understand how my stamp duty is calculated
As a home buyer
I want to see what percentages apply to the purchase price

Scenario: As a home buyer
  Given I visit the Stamp Duty page
  And I am a first time buyer
  Then I should see the stamp duty percentages for first time buyers as:
    | Purchase Price of property | Rate of Stamp Duty | Buy to Let/Additional Home Rate* |
    | £0 - £125,000              | 0%                 | 3%           |
    | £125,001 - £250,000        | 2%                 | 5%           |
    | £250,001 - £925,000        | 3%                 | 8%           |
    | £925,001 - £1,500,000      | 10%                | 13%          |
    | over £1.5 million          | 12%                | 15%          |
