Feature: Mortgage Affordability Calculator
As a potential mortgage customer
I want to know much of a mortgage I can borrow
So that I can determine my ability to buy a property

Scenario: Enter valid details on all steps for single applicant
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see how much I can borrow

Scenario: Enter valid details on all steps for two applicants
  Given I visit the affordability page
  When  I enter all details for two applicants
  Then  I should see how much I can borrow

Scenario: Enter invalid details on step one for single applicant
  Given I visit the affordability page
  When  I enter invalid details on step one for single applicant
  Then  I should see a list of errors

Scenario: Monthly income more than available income for single applicant
  Given I visit the affordability page
  When  I enter too much monthly income for single applicant
  Then  I should see a list of errors

Scenario: Monthly income more than available income for two applicants
  Given I visit the affordability page
  When  I enter too much monthly income for two applicants
  Then  I should see a list of errors

Scenario: Monthly income more than available income for second applicant
  Given I visit the affordability page
  When  I enter too much monthly income for the second applicant
  Then  I should see a list of errors
  And   I should see different errors for the second applicant

Scenario: Enter invalid details on step two for single applicant
  Given I visit the affordability page
  And   I enter valid details on step one for single applicant
  When  I enter invalid details on step two
  Then  I should see a list of errors

Scenario: Enter invalid details on step three for single applicant
  Given I visit the affordability page
  And   I enter valid details on step one for single applicant
  And   I enter valid details on step two
  When  I recalculate with invalid details
  Then  I should see a list of errors

Scenario: Enter invalid details on step one for two applicants
  Given I visit the affordability page
  When  I enter invalid details on step one for two applicants
  Then  I should see a list of errors
  And   I should see different errors for the second applicant

Scenario: Enter invalid details on step two for two applicants
  Given I visit the affordability page
  And   I enter valid details on step one for two applicants
  When  I enter invalid details on step two
  Then  I should see a list of errors

Scenario: Enter invalid details on step three for two applicants
  Given I visit the affordability page
  And   I enter valid details on step one for two applicants
  And   I enter valid details on step two
  When  I recalculate with invalid details
  Then  I should see a list of errors

Scenario: Recalculate details for single applicant
  Given I visit the affordability page
  And   I enter all details for single applicant
  When  I recalculate with invalid details
  Then  I should see a list of errors

Scenario: Recalculate details for two applicants
  Given I visit the affordability page
  And   I enter all details for two applicants
  When  I recalculate with invalid details
  Then  I should see a list of errors

Scenario Outline: Single person calculations
  Given I visit the affordability page
  And   I add an income of <annual>, extras of <extra> and monthly net of <monthly>
  And   household costs of <credit>, <maint>, <care>, <travel>, <bills> and <rent>
  And   living costs of <ents>, <hols> and <food>
  When  I set the term to <term> and interest to <rate>
  Then  the offered range is expected to be between "<min>" and "<max>"
  And   the borrowing amount is expected to be "<borrowing>"
  And   the monthly repayments are expected to be "<payments>"
  And   the remaining per month is expected to be "<remaining>"
  And   the spending commitment is expected to be "<commit>"
  And   the risk percentage is expected to be "<risk_pct>"
  And   the essentials are expected to have a percent of "<risk_pct>" and an amount of "<ess_amt>"
  And   the leftovers are expected to have a percent of "<left_pct>" and an amount of "<left_amt>"
  And   the amount on interest increase is expected to be "<increase>"
  And   the buffer on interest increase is expected to be "<buffer>"

Examples:
  | annual | extra | monthly | credit | maint | care | travel | bills | rent | ents | hols | food | term | rate | min      | max      | borrowing | payments  | remaining | commit  | risk_pct | ess_amt   | left_pct | left_amt  | increase  | buffer    |
  | 100000 | 0     | 5428.44 | 0      | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £280,000 | £420,000 | 350,000   | £1,659.74 | £3,768.70 | £0.00   | 31%      | £1,659.74 | 69%      | £3,768.70 | £2,046.07 | £3,382.37 |
  | 100000 | 10000 | 5745.10 | 300    | 300   | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £287,840 | £431,760 | 359,800   | £1,706.21 | £3,438.89 | £600.00 | 40%      | £2,306.21 | 60%      | £3,438.89 | £2,103.35 | £3,041.75 |
  | 50000  | 0     | 2714.22 | 60     | 140   | 0    | 0      | 250   | 0    | 0    | 0    | 0    | 25   | 3    | £133,280 | £199,920 | 166,600   | £790.04   | £1,474.18 | £450.00 | 46%      | £1,240.04 | 54%      | £1,474.18 | £973.93   | £1,290.29 |
  | 60000  | 0     | 3495.10 | 0      | 0     | 0    | 180    | 290   | 0    | 400  | 0    | 300  | 25   | 3    | £168,000 | £252,000 | 210,000   | £995.84   | £1,329.26 | £470.00 | 42%      | £1,465.84 | 58%      | £2,029.26 | £1,227.64 | £1,097.46 |
  | 57000  | 0     | 3100    | 500    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £142,800 | £214,200 | 178,500   | £846.47   | £1,753.53 | £500.00 | 43%      | £1,346.47 | 57%      | £1,753.53 | £1,043.49 | £1,556.51 |
  | 57000  | 0     | 3100    | 500    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 35   | 3    | £142,800 | £214,200 | 178,500   | £686.96   | £1,913.04 | £500.00 | 38%      | £1,186.96 | 62%      | £1,913.04 | £900.87   | £1,699.13 |
  | 57000  | 0     | 3100    | 500    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 15   | 5    | £142,800 | £214,200 | 178,500   | £1,411.57 | £1,188.43 | £500.00 | 62%      | £1,911.57 | 38%      | £1,188.43 | £1,604.41 | £995.59   |
  | 25000  | 0     | 1700    | 350    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £58,240  | £87,360  | 72,800    | £345.23   | £1,004.77 | £350.00 | 41%      | £695.23   | 59%      | £1,004.77 | £425.58   | £924.42   |
  | 25000  | 0     | 1700    | 350    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 35   | 3    | £58,240  | £87,360  | 72,800    | £280.17   | £1,069.83 | £350.00 | 37%      | £630.17   | 63%      | £1,069.83 | £367.41   | £982.59   |
  | 25000  | 0     | 1700    | 350    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 35   | 5    | £58,240  | £87,360  | 72,800    | £367.41   | £982.59   | £350.00 | 42%      | £717.41   | 58%      | £982.59   | £465.09   | £884.91   |
  | 25000  | 0     | 1700    | 350    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 40   | 5    | £58,240  | £87,360  | 72,800    | £351.04   | £998.96   | £350.00 | 41%      | £701.04   | 59%      | £998.96   | £452.40   | £897.60   |

Scenario Outline: Two people calculations
  Given I visit the affordability page
  And   I add an income of <annual>, extras of <extra> and monthly net of <monthly>
  And   a second person with an income of <annual2>, extras of <extra2> and monthly net of <monthly2>
  And   household costs of <credit>, <maint>, <care>, <travel>, <bills> and <rent>
  And   living costs of <ents>, <hols> and <food>
  When  I set the term to <term> and interest to <rate>
  Then  the offered range is expected to be between "<min>" and "<max>"
  And   the borrowing amount is expected to be "<borrowing>"
  And   the monthly repayments are expected to be "<payments>"
  And   the remaining per month is expected to be "<remaining>"
  And   the spending commitment is expected to be "<commit>"
  And   the risk percentage is expected to be "<risk_pct>"
  And   the essentials are expected to have a percent of "<risk_pct>" and an amount of "<ess_amt>"
  And   the leftovers are expected to have a percent of "<left_pct>" and an amount of "<left_amt>"
  And   the amount on interest increase is expected to be "<increase>"
  And   the buffer on interest increase is expected to be "<buffer>"

Examples:
  | annual | extra | monthly | annual2 | extra2 | monthly2 | credit | maint | care | travel | bills | rent | ents | hols | food | term | rate | min      | max      | borrowing | payments  | remaining | commit    | risk_pct | ess_amt   | left_pct | left_amt  | increase  | buffer    |
  | 50000  | 0     | 2714.22 | 50000   | 0      | 2714.22  | 0      | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £280,000 | £420,000 | 350,000   | £1,659.74 | £3,768.70 | £0.00     | 31%      | £1,659.74 | 69%      | £3,768.70 | £2,046.07 | £3,382.37 |
  | 50000  | 5000  | 3253.44 | 50000   | 5000   | 3253.44  | 0      | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 3    | £308,000 | £462,000 | 385,000   | £1,825.71 | £4,681.17 | £0.00     | 28%      | £1,825.71 | 72%      | £4,681.17 | £2,250.67 | £4,256.21 |
  | 25000  | 0     | 1662.89 | 25000   | 0      | 1662.89  | 200    | 0     | 250  | 0      | 300   | 0    | 0    | 0    | 0    | 25   | 3    | £133,280 | £199,920 | 166,600   | £790.04   | £1,785.74 | £750.00   | 46%      | £1,540.04 | 54%      | £1,785.74 | £973.93   | £1,601.85 |
  | 40000  | 0     | 2512.89 | 35000   | 0      | 2229.56  | 300    | 0     | 0    | 600    | 325   | 0    | 400  | 0    | 300  | 25   | 3    | £199,920 | £299,880 | 249,900   | £1,185.05 | £1,632.40 | £1,225.00 | 51%      | £2,410.05 | 49%      | £2,332.40 | £1,460.89 | £1,356.56 |
  | 100000 | 10000 | 6000    | 50000   | 5000   | 3000     | 300    | 300   | 300  | 300    | 300   | 300  | 300  | 300  | 300  | 25   | 3    | £441,840 | £662,760 | 552,300   | £2,619.07 | £3,980.93 | £1,500.00 | 46%      | £4,119.07 | 54%      | £4,880.93 | £3,228.69 | £3,371.31 |
  | 25000  | 0     | 1500    | 33000   | 0      | 1750     | 750    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 25   | 4    | £137,200 | £205,800 | 171,500   | £905.24   | £1,594.76 | £750.00   | 51%      | £1,655.24 | 49%      | £1,594.76 | £1,104.98 | £1,395.02 |
  | 25000  | 0     | 1500    | 33000   | 0      | 1750     | 750    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 33   | 2    | £137,200 | £205,800 | 171,500   | £591.95   | £1,908.05 | £750.00   | 41%      | £1,341.95 | 59%      | £1,908.05 | £780.67   | £1,719.33 |
  | 25000  | 0     | 1500    | 33000   | 0      | 1750     | 750    | 0     | 0    | 0      | 0     | 0    | 0    | 0    | 0    | 10   | 5    | £137,200 | £205,800 | 171,500   | £1,819.02 | £680.98   | £750.00   | 79%      | £2,569.02 | 21%      | £680.98   | £1,991.26 | £508.74   |

Scenario: Repayment term tooltip
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see the repayment term tooltip

@javascript
Scenario: Adjusting the interest rate in JavaScript
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see the correct results for a single applicant for JavaScript
  And   I should be able to tweak the results by adjusting the interest rate text for JavaScript

@javascript
Scenario: Adjusting the interest rate slider
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see the correct results for a single applicant for JavaScript
  And   I should be able to tweak the results by adjusting the interest rate slider

@javascript
Scenario: Adjusting the mortgage term in JavaScript
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see the correct results for a single applicant for JavaScript
  And   I should be able to tweak the results by adjusting the mortgage term text for JavaScript

@javascript
Scenario: Adjusting the mortgage term slider
  Given I visit the affordability page
  When  I enter all details for single applicant
  Then  I should see the correct results for a single applicant for JavaScript
  And   I should be able to tweak the results by adjusting the mortgage term slider
