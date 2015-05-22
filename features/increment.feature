@javascript
Feature: Increment
  In order to count
  A visitor
  Should be able to increase a counter

  Scenario: Increment a counter
    When I click on a counter
    Then counter should have increased by 1

  Scenario: Don't increment a counter
    When I click on a description of a counter
    Then counter should have not increased by 1