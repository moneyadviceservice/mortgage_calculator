Feature: Affordability Calculator
So that I can determine my affordability
As a user
I want to enter my income and expenses

Scenario: Can view the Affordability Calculator
  Given I visit the Affordability page
  Then  I should see the Affordability title


@with_and_without_javascript
Scenario: Affordability for one applicant
  Given I visit the Affordability page
  When  I enter all details for "1" applicants
  Then  I see "between £287,840.00 and £431,760.00"
  And   I see "Estimated mortgage repayments per month, approx: £2,103.35"
  And   I see "remaining money per month is £1,496.65"
  And   I see "Estimated fixed and spending commitments per month are: £1,500.00"
  And   I see "If interest rate changes by 2% your monthly repayment would rise to £2,542.99"
  And   I see "Your remaining financial buffer will be £1,057.01"

Scenario: I recalculate
  Given I have entered all details for applicant "1"
  When  I update my affordability circumstances
  And   I recalculate
  Then  I see "79% of your monthly take-home"
  And   I see "remaining money per month is £330.49"
  And   I see "Estimated fixed and spending commitments per month are: £1,500.00"


Scenario Outline: There are two applicants with extra income and commited spend
  Given I visit the Affordability page

  And I enter annual_income <annual_income>
  And I enter extra_income <extra_income>
  And I enter monthly_net_income <monthly_net_income>

  And I enter person_two_annual_income <person_two_annual_income>
  And I enter person_two_extra_income <person_two_extra_income>
  And I enter person_two_monthly_net_income <person_two_monthly_net_income>

  And I submit the details

  And I enter credit_repayments <credit_repayments>
  And I enter utilities <utilities>
  And I enter childcare <childcare>
  And I enter child_maintenance <child_maintenance>
  And I enter rent_and_mortgage <rent_and_mortgage>
  And I enter food <food>
  And I enter travel <travel>
  And I enter entertainment <entertainment>
  And I enter holiday <holiday>

  And I submit the details

  Then  I see "between <range_min> and <range_max>"
  And   I see "Estimated mortgage repayments per month, approx: <repayment_per_month>"
  And   I see "remaining money per month is <remaining_per_month>"
  And   I see "Estimated fixed and spending commitments per month are: <spending_commitments>"
  And   I see "If interest rate changes by 2% your monthly repayment would rise to <increased_monthly_repayment>"
  And   I see "Your remaining financial buffer will be <financial_buffer>"

  Examples:
  | annual_income | extra_income | monthly_net_income | person_two_annual_income | person_two_extra_income | person_two_monthly_net_income | credit_repayments | utilities | childcare | child_maintenance | rent_and_mortgage | food | travel | entertainment | holiday | range_min   | range_max   | repayment_per_month | remaining_per_month | spending_commitments | increased_monthly_repayment | financial_buffer |
  | 100000        | 0            | 5428.44            | 0                        | 0                       | 0                             | 0                 | 0         | 0         | 0                 | 0                 | 0    | 0      | 0             | 0       | £280,000.00 | £420,000.00 | £2,046.07           | £3,382.37           |                      | £2,473.73                   | £2,954.71        |
  | 50000         | 0            | 2714.22            | 50000                    | 0                       | 2714.22                       | 0                 | 0         | 0         | 0                 | 0                 | 0    | 0      | 0             | 0       | £280,000.00 | £420,000.00 | £2,046.07           | £3,382.37           |                      | £2,473.73                   | £2,954.71        |
  # | 100000        | 10000        | 5745.10            | 0                        | 0                       | 0                             | 300               | 0         | 0         | 300               | 0                 | 0    | 0      | 0             | 0       | £287,840.00 | £431,760.00 | £2,103.35           | £3,296.65           |                      | £2,542.99                   | £2,857.01        |
  | 50000         | 5000         | 3253.44            | 50000                    | 5000                    | 3253.44                       | 0                 | 0          | 0        | 0                 | 0                 | 0    | 0      | 0             | 0       | £308,000.00 | £462,000.00 | £2,250.67           | £4,256.21           |                      | £2,721.10                   | £3,785.78        |
  | 50000         | 0            | 2714.22            | 0                        | 0                       | 0                             | 60                | 250       | 0         | 140               | 0                 | 0    | 0      | 0             | 0       | £133,280.00 | £199,920.00 | £973.93             | £1,290.29           |                      | £1,177.49                   | £1,086.73        |
  | 25000         | 0            | 1662.89            | 25000                    | 0                       | 1662.89                       | 200               | 300       | 250       | 0                 | 0                 | 0    | 0      | 0             | 0       | £133,280.00 | £199,920.00 | £973.93             | £1,601.85           |                      | £1,177.49                   | £1,398.29        |
  | 60000         | 0            | 3495.10            | 0                        | 0                       | 0                             | 0                 | 290       | 0         | 0                 | 0                 | 300  | 180    | 400           | 0       | £168,000.00 | £252,000.00 | £1,227.64           | £1,097.46           |                      | £1,484.24                   | £840.86          |
  | 40000         | 0            | 2512.89            | 35000                    | 0                       | 2229.56                       | 300               | 325       | 0         | 0                 | 0                 | 300  | 600    | 400           | 0       | £199,920.00 | £299,880.00 | £1,460.89           | £1,356.56           |                      | £1,766.24                   | £1,051.21        |
  | 100000        | 10000        | 6000               | 50000                    | 5000                    | 3000                          | 300               | 300       | 300       | 300               | 300               | 300  | 300    | 300           | 300     | £441,840.00 | £662,760.00 | £3,228.69           | £3,371.31           | £1,500.00            | £3,903.54                   | £2,696.46        |

Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message

