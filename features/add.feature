@javascript
Feature: Add
  In order to count
  A User
  Should be able to add a counter

  Scenario: Add Counter
    When I sign in with "dunyakirkali@gmail.com"
    When I add a counter
    Then I should have two counters