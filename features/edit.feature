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

  Scenario: Don't Edit Counter
   Given There is a palette
    When I sign in with "dunyakirkali@gmail.com"
    When I edit a counter
     And I fill counter form without name
    Then page should have "Name can't be blank"
