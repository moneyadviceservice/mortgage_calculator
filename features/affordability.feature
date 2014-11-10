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

# See YAML file located 'http://github.com/.../...' for these calculations
Scenario: Accurate calculations
  Given I visit the affordability page
  And   I enter various income and expense details
  Then  I should see accurate calculations
