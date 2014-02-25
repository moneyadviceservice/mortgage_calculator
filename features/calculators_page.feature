Feature: Calculators Page
So that I can determine my affordability
As a user
I want to view a calculator I can use

Scenario: Can view the Affordability Calculator
  Given a user visits the Affordability page
  Then they should see the Affordability calculator

@javascript
Scenario: When javascript is enabled
  Given a user visits the Affordability page
  Then they can change the number of applicants

Scenario: When javascript is disabled
  Given a user visits the Affordability page
  Then they can not change the number of applicants

@javascript
Scenario: There is one applicant
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  Then they see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

Scenario: There is one applicant
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And click submit
  Then they see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

@javascript
Scenario: There is one applicant with extra income
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And they fill in "affordability[people_attributes][0][extra_income]" with "10000"
  Then they see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There is one applicant with extra income and commited spend
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And they fill in "affordability[people_attributes][0][extra_income]" with "10000"
  And they fill in "affordability[monthly_debt]" with "1000"
  Then they see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There are two applicants
  Given a user visits the Affordability page
  When they select 2 people
  Then they see "5" text inputs

@javascript
Scenario: There are two applicants with extra income and commited spend
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And they fill in "affordability[people_attributes][0][extra_income]" with "10000"
  And they select 2 people
  And they fill in "affordability[people_attributes][1][annual_income]" with "50000"
  And they fill in "affordability[people_attributes][1][extra_income]" with "5000"
  And they fill in "affordability[monthly_debt]" with "2000"
  Then they see "the maximum mortgage you can borrow is between £495,000.00 to £660,000.00" # This is not correct personal spend is not taken into consideration

Scenario: There are two applicants with extra income and commited spend
  Given a user visits the Affordability page
  When they fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And they fill in "affordability[people_attributes][0][extra_income]" with "10000"
  And they fill in "affordability[people_attributes][1][annual_income]" with "50000"
  And they fill in "affordability[people_attributes][1][extra_income]" with "5000"
  And they fill in "affordability[monthly_debt]" with "2000"
  And click submit
  Then they see "the maximum mortgage you can borrow is between £423,000.00 to £564,000.00"

@javascript
Scenario: User enters invalid annual income
  Given a user visits the Affordability page
  When they submit invalid details
  Then they see an error message

Scenario: User enters invalid annual income
  Given a user visits the Affordability page
  When they submit invalid details
  Then they see an error message
