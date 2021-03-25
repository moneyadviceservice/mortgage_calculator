Feature: Land Buildings Transaction Tax - First Time Buyer
So that I know how much land buildings transaction tax to pay
As a user buying my first home in Scotland
I want to enter my house price

Background:
  Given I visit the land and buildings transaction tax page

Scenario Outline: land and buildings transaction tax for first home
  When I enter a house price of <price>
  And I enter a completion date of "2021-04-21"
  And I am a first time buyer
  And I click next
  Then I see the title for the "Land and Buildings Transaction Tax (LBTT)" results page
  And I see the call out box with everything I need to know
  And I see the stamp duty I will have to pay is "£<duty>"
  And I see the effective tax rate is "<effective tax>"

Examples:
  | price   | duty     | effective tax |
  | 39000   | 0        | 0.00%         |
  | 40000   | 0        | 0.00%         |
  | 120000  | 0        | 0.00%         |
  | 175000  | 0        | 0.00%         |
  | 201000  | 520      | 0.26%         |
  | 250000  | 1,500    | 0.60%         |
  | 300000  | 4,000    | 1.33%         |
  | 325000  | 5,250    | 1.62%         |
  | 400000  | 12,750   | 3.19%         |
  | 743000  | 47,050   | 6.33%         |
  | 750000  | 47,750   | 6.37%         |
  | 1200000 | 101,750  | 8.48%         |

@javascript
Scenario Outline: land and buildings transaction tax for first home
  When I enter a house price of <price>
  And I enter a completion date of "2021-04-21"
  And I am a first time buyer
  And I click next
  Then I see the call out box with everything I need to know
  And I see the stamp duty I will have to pay is "£<duty>"
  And I see the effective tax rate is "<effective tax>"

Examples:
  | price   | duty     | effective tax |
  | 39000   | 0        | 0.00%         |
  | 40000   | 0        | 0.00%         |
  | 120000  | 0        | 0.00%         |
  | 175000  | 0        | 0.00%         |
  | 201000  | 520      | 0.26%         |
  | 250000  | 1,500    | 0.60%         |
  | 300000  | 4,000    | 1.33%         |
  | 325000  | 5,250    | 1.62%         |
  | 400000  | 12,750   | 3.19%         |
  | 743000  | 47,050   | 6.33%         |
  | 750000  | 47,750   | 6.37%         |
  | 1200000 | 101,750  | 8.48%         |
