Feature: Affordability Calculator Feedback
So that I can make MAS better
As a user
I want to be able to give feedback

Scenario: When entering my income details
  Given I visit the Affordability page
  Then  I should see the affordability feedback tab

Scenario: When using syndicated affordability calculator
  Given I visit the Syndicated Affordability page
  Then  I should not see the affordability feedback tab
