Feature: Land Buildings Transaction Tax - How is this calculated panel
So that I know how much land buildings transaction tax to pay
As a user buying my first home in Scotland
I want to see an explanation of how lbtt is calculated  

Scenario: LBTT How is this calculated panel - First time buyer journey
  Given I visit the land and buildings transaction tax page
  And I fill in details for a first time buyer
  When I progress to the results page
  And I click on the How is this Calculated information icon
  Then I should see the values on the information panel as:
  | Purchase price | Standard LBTT bill | Amount of First-time Buyer Relief | Total to pay for a first-time buyer | 
  | Up to £145,000 | £0                 | £0                                |  £0                                 |
  | £155,000       | £200               | £200                              |  £0                                 |
  | £175,000       | £600               | £600                              |  £0                                 |
  | £250,000       | £2,100             | £600                              |  £1,500                             |
  | £325,500       | £5,900             | £600                              |  £5,300                             |
  | £750,500       | £48,410            | £600                              |  £47,810                            |

Scenario: LBTT How is this calculated panel - Next home buyer journey
  Given I visit the land and buildings transaction tax page
  And I fill in details for a next home buyer
  When I progress to the results page
  And I click on the How is this Calculated information icon
  Then I should see the values on the information panel as:
  | Purchase price      | Rate of Land and Buildings Transaction Tax (LBTT) | Buy to Let/ Additional Dwelling Supplement (ADS)* |
  | Up to £145,000      | 0%                 | 4%                                |
  | £145,001 - £250,000 | 2%                 | 6%                                |
  | £250,001 - £325,000 | 5%                 | 9%                                |
  | £325,001 - £750,000 | 10%                | 14%                               |
  | Over £750,000       | 12%                | 16%                               |

Scenario: LBTT How is this calculated panel - Additional home buyer journey
  Given I visit the land and buildings transaction tax page
  And I fill in details for a additional home buyer
  When I progress to the results page
  And I click on the How is this Calculated information icon
  Then I should see the values on the information panel as:
  | Purchase price      | Rate of Land and Buildings Transaction Tax (LBTT) | Buy to Let/ Additional Dwelling Supplement (ADS)* |
  | Up to £145,000      | 0%                 | 4%                                |
  | £145,001 - £250,000 | 2%                 | 6%                                |
  | £250,001 - £325,000 | 5%                 | 9%                                |
  | £325,001 - £750,000 | 10%                | 14%                               |
  | Over £750,000       | 12%                | 16%                               |