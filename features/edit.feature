@javascript
Feature: Edit
  In order to count
  A User
  Should be able to edit a counter

  Scenario: Edit Counter
    When I sign in with "dunyakirkali@gmail.com"
    When I edit a counter
     And I fill counter form
    Then Counter name should have changed
