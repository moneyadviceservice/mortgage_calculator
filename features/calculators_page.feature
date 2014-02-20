Feature: Calculators Page
So that I can determine my affordability
As a user
I want to view a calculator I can use

Scenario: Can view the Affordability Calculator
  Given a user visits the Affordability page
  Then they should see the Affordability calculator

@javascript
Scenario: There is one applicant
  Given a user visits the Affordability page
  When they fill in "annualIncome" with "100000"
  Then they see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

@javascript
Scenario: There is one applicant with extra income
  Given a user visits the Affordability page
  When they fill in "annualIncome" with "100000"
  And they fill in "extraIncome" with "10000"
  Then they see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There is one applicant with extra income and commited spend
  Given a user visits the Affordability page
  When they fill in "annualIncome" with "100000"
  And they fill in "extraIncome" with "10000"
  And they fill in "committedSpend" with "1000"
  Then they see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There are two applicants with extra income and commited spend
  Given a user visits the Affordability page
  When they fill in "annualIncome" with "100000"
  And they fill in "extraIncome" with "10000"
  And they select 2 people
  And they fill in "personTwoAnnualIncome" with "50000"
  And they fill in "personTwoExtraIncome" with "5000"
  And they fill in "committedSpend" with "2000"
  Then they see "the maximum mortgage you can borrow is between £495,000.00 to £660,000.00"
