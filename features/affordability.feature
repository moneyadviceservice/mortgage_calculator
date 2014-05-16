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

@javascript @wip
Scenario: There is one applicant
  Given I visit the Affordability page
  When  I enter some details for applicant "1"
  Then  I see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

@javascript @wip
Scenario: There is one applicant with extra income
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  Then  I see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript @wip
Scenario: There is one applicant with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  Then  I see "the maximum mortgage you can borrow is between £294,000.00 to £392,000.00"

@wip @javascript
Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I select 2 people
  And   I enter all details for applicant "2"
  Then  I see "the maximum mortgage you can borrow is between £423,000.00 to £564,000.00"

Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I enter all details for applicant "2"
  And   I submit the details
  Then  I see "You might be offered between £441,840.00 and £662,760.00"
  And   I see "Remaining per month is £3,671.31"
  And   I see "Fixed costs are £1,500.00"

@javascript @wip
Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I do not see the result output

Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message
