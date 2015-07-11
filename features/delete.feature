@javascript
Feature: Delete
  In order to count
  A User
  Should be able to delete a counter

  Scenario: Delete Counter
    When I sign in with "dunyakirkali@gmail.com"
    When I edit a counter
     And I click on Delete
    Then Counter should be deleted
