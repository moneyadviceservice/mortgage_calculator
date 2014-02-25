Feature: Calculators Page
So that I can determine my affordability
As a user
I want to enter my income and expenses

Scenario: Can view the Affordability Calculator
  Given I visit the Affordability page
  Then  I should see the Affordability calculator

@javascript
Scenario: When javascript is enabled
  Given I visit the Affordability page
  Then  I can change the number of applicants

Scenario: When javascript is disabled
  Given I visit the Affordability page
  Then  I can not change the number of applicants

@javascript
Scenario: There is one applicant
  Given I visit the Affordability page
  When  I fill in "affordability[people_attributes][0][annual_income]" with "100000"
  Then  I see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

Scenario: There is one applicant
  Given I visit the Affordability page
  When  I fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And   click submit
  Then  I see "the maximum mortgage you can borrow is between £300,000.00 to £400,000.00"

@javascript
Scenario: There is one applicant with extra income
  Given I visit the Affordability page
  When  I fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And   I fill in "affordability[people_attributes][0][extra_income]" with "10000"
  Then  I see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There is one applicant with extra income and commited spend
  Given I visit the Affordability page
  When  I fill in "affordability[people_attributes][0][annual_income]" with "100000"
  And   I fill in "affordability[people_attributes][0][extra_income]" with "10000"
  And   I fill in "affordability[monthly_debt]" with "1000"
  Then  I see "the maximum mortgage you can borrow is between £330,000.00 to £440,000.00"

@javascript
Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I select 2 people
  And   I enter all details for applicant "2"
  And   I enter their monthly debt
  Then  I see "the maximum mortgage you can borrow is between £423,000.00 to £564,000.00"

Scenario: There are two applicants with extra income and commited spend
  Given I visit the Affordability page
  When  I enter all details for applicant "1"
  And   I enter all details for applicant "2"
  And   I enter their monthly debt
  And   submit their details
  Then  I see "the maximum mortgage you can borrow is between £423,000.00 to £564,000.00"

@javascript
Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message

Scenario: I enter invalid details
  Given I visit the Affordability page
  When  I submit invalid details
  Then  I see an error message
