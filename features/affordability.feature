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
  And   I see "remaining money per month is £330.50"
  And   I see "Estimated fixed and spending commitments per month are: £1,500.00"

@with_and_without_javascript
Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  And   I enter all details for "2" applicants
  Then  I see "between £441,840.00 and £662,760.00"
  And   I see "Estimated mortgage repayments per month, approx: £3,228.69"
  And   I see "remaining money per month is £3,371.31"
  And   I see "Estimated fixed and spending commitments per month are: £1,500.00"
  And   I see "If interest rate changes by 2% your monthly repayment would rise to £3,903.54"
  And   I see "Your remaining financial buffer will be £2,696.46"

Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message

