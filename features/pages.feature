@javascript
Feature: Pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Browse about page
    When I visit "about"
  Then page should have "Because we love statistics"

  Scenario: Browse welcome page
    When I visit "welcome"
    Then page should have "Sign in with Google"

  Scenario: Link to about page
    Given Guest visit root path
    When I click on "About"
    Then page should have "Because we love statistics"
