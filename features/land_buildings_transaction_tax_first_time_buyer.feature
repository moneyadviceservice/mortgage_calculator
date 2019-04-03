Feature: Land Buildings Transaction Tax - First Time Buyer
So that I know how much land buildings transaction tax to pay
As a user buying my first home in Scotland
I want to enter my house price

Background:
  Given I visit the land and buildings transaction tax page

Scenario Outline: land and buildings transaction tax for first home
  When I enter a house price of <price>
  And I am a first time buyer
  And I click next
  Then I see the title for the "Land and Buildings Transaction Tax (LBTT)" results page
  And I see the call out box with everything I need to know
  And I see the stamp duty I will have to pay is "£<duty>"

Examples:
  |  price    |  duty    |
  |  120000   |  0       |
  |  175000   |  0       |
  |  201000   |  520     |
  |  250000   |  1,500   |
  |  300000   |  4,000   |
  |  325000   |  5,250   |
  |  400000   |  12,750  |
  |  743000   |  47,050  |
  |  750000   |  47,750  |
  |  1200000  |  101,750 |

@javascript
Scenario Outline: land and buildings transaction tax for first home
  When I enter a house price of <price>
  And I am a first time buyer
  And I click next
  Then I see the call out box with everything I need to know
  And I see the stamp duty I will have to pay is "£<duty>"

Examples:
  | price      | duty     |
  |  120000    |  0       |
  |  175000    |  0       |
  |  201000    |  520     |
  |  250000    |  1,500   |
  |  300000    |  4,000   |
  |  325000    |  5,250   |
  |  400000    |  12,750  |
  |  743000    |  47,050  |
  |  750000    |  47,750  |
  |  1200000   |  101,750 |
