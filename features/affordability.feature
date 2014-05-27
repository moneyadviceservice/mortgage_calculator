Feature: Affordability Calculator
So that I can determine my affordability
As a user
I want to enter my income and expenses

Scenario: Can view the Affordability Calculator
  Given I visit the Affordability page
  Then  I should see the Affordability title

Scenario: Affordability for one applicant
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I submit the details
  Then  I see "You might be offered between £287,840.00 and £431,760.00"
  And   I see "Remaining per month is £1,796.65"
  And   I see "Fixed costs are £1,500.00"

Scenario: I recalculate
  Given I have entered all details for applicant "1"
  When  I update my affordability circumstances
  And   I recalculate
  Then  I see "64% of your monthly take home"
  And   I see "Remaining per month is £630.50"
  And   I see "Fixed costs are £1,500.00"


Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I enter all details for applicant "2"
  And   I submit the details
  Then  I see "You might be offered between £441,840.00 and £662,760.00"
  And   I see "Remaining per month is £3,671.31"
  And   I see "Fixed costs are £1,500.00"


Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message

@javascript
Scenario: Affordability for one applicant
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I submit the details
  Then  I see "You may be offered a range between £287,840.00 to £431,760.00"
  And   I see "Estimated mortgage repayments per month, approx: £2,103.35"
  And   I see "Estimated fixed and spending commitments per month are: £600.00"
  And   I see "Your estimated remaining money per month is £1,496.65"
  And   I see "If interest rate changes by 2% your monthly repayment would rise to £2,542.99"
  And   I see "Your remaining financial buffer will be £1,057.01"

@javascript
Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I enter all details for applicant "2"
  And   I submit the details
  Then  I see "You may be offered a range between £441,840.00 to £662,760.00"
  And   I see "Estimated mortgage repayments per month, approx: £3,228.69"
  And   I see "Your estimated remaining money per month is £3,371.31"
  And   I see "If interest rate changes by 2% your monthly repayment would rise to £3,903.54"
  And   I see "Your remaining financial buffer will be £2,696.46"


