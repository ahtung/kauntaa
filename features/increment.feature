@javascript
Feature: Increment
  In order to count
  User
  Should be able to increase a counter

  Scenario: Increment a counter
    Given User home page
    When I visit click to a counter
    Then counter should have increased by 1

  Scenario: Don't increment a counter
    Given User home page
    When I click on a description of a counter
    Then counter should not have changed