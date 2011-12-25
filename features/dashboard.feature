Feature: Dashboard
  In order to manage articles
  As an administrator
  I want to have a dashboard

  Scenario: regular visitor goes to the dashboard
    Given I am not logged in
    When I go to the dashboard page
    Then I should see "Login required"

  Scenario: regular user goes to the dashboard
    Given I am a regular user
    When I go to the dashboard page
    Then I should see "Access denied"

  Scenario: administrator goes to dashboard
    Given I am an administrator
    When I go to the dashboard page
    Then I should see "Recent articles"

