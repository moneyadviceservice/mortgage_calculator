Feature: Stamp Duty Calculator
So that I know how much stamp duty to pay
As a user
I want to enter my house price

Scenario: Can view the Stamp Duty Calculator
  Given I visit the Stamp Duty page
  Then they should see the Stamp Duty calculator

Scenario: When javascript is enabled
  Given I visit the Stamp Duty page
  When  I enter my house price
  Then  I see how much stamp duty I will have to pay

Scenario: House price which is less than £125,000
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "120000"
  Then they see "Based on your total purchase price of £120,000.00, you will have to pay 0% in stamp duty, costing £0.00. Bringing your total spend to £120,000.00."

Scenario: House price which is over £125,000
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "126000"
  Then they see "Based on your total purchase price of £126,000.00, you will have to pay 1% in stamp duty, costing £1,260.00. Bringing your total spend to £127,260.00."

Scenario: House price which is over £250,000
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "260000"
  Then they see "Based on your total purchase price of £260,000.00, you will have to pay 3% in stamp duty, costing £7,800.00. Bringing your total spend to £267,800.00."

Scenario: House price which is over £500,000
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "510000"
  Then they see "Based on your total purchase price of £510,000.00, you will have to pay 4% in stamp duty, costing £20,400.00. Bringing your total spend to £530,400.00."

Scenario: House price which is over £1 million
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "1100000"
  Then they see "Based on your total purchase price of £1,100,000.00, you will have to pay 5% in stamp duty, costing £55,000.00. Bringing your total spend to £1,155,000.00."

Scenario: House price which is over £2 million
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "2100000"
  Then they see "Based on your total purchase price of £2,100,000.00, you will have to pay 7% in stamp duty, costing £147,000.00. Bringing your total spend to £2,247,000.00."

@wip
Scenario: User enters invalid property price
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "sx"
  Then they do not see the result output

@wip
Scenario: User enters 0 as the property price
  Given I visit the Stamp Duty page
  When they enter the cost of a property with "0"
  Then they do not see the result output
