@javascript
Feature: Add
  In order to count soething new
  A User
  Should be able to add a new counter

  Scenario: Add Counter
   Given There is a palette
    When I sign in with "dunyakirkali@gmail.com"
     And I add a counter
    Then I should have two counters

  Scenario: Don't Add Counter
   Given There is a palette
    When I sign in with "dunyakirkali@gmail.com"
     And I add a counter without name
    Then page should have "Counter cannot be created."
