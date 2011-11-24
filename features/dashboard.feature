Feature: Dashboard
  In order to manage articles
  As an administrator
  I want to have a dashboard
  
  Scenario: Unregistered user tries to go to the dashboard
    Given I am not logged in
    When I go to the dashboard page
    Then I should see "Login required"
    
  Scenario: regular user goes to the dashboard
    Given I am logged in
    And I am a regular user
    When I go to the dashboard page
    Then I shuold see "Access denied"

  Scenario: administrator goes to dashboard
    Given I am  logged in
    And I am an administrator
    When I go to the dashboard page
    Then I should see "Recent articles"
  
  
  