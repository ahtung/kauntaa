@javascript
Feature: Add
  In order to count
  A User
  Should be able to add a counter

  Scenario: Add Counter
    Given I have no counters
    When I add a counter
    Then I should have a couter