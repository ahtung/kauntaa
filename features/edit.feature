@javascript
Feature: Edit
  In order to count
  A User
  Should be able to edit a counter

  Scenario: Edit Counter
    When I sign in with "dunyakirkali@gmail.com"
    When I click on a description of a counter
    Then Counter name should have changed