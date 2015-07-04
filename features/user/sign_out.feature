@javascript
Feature: Sign out
  In order to sign out
  A signed in User
  Should be able to sign out

  Scenario: Sign Out
    Given I sign in with "dunyakirkali@gmail.com"
    When I click on sign out
    Then I should have signed out