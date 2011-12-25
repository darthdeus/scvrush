Feature: upcoming tournaments

  Background:
    Given I am an administrator
    And I go to the dashboard page

  Scenario: displaying upcoming tournaments
    Given I have 5 tournaments
    Then I should see the last tournament in the list

  Scenario: administrator wants to change the upcoming tournaments
    Given I have 5 tournaments
    When I select a tournament in the upcoming section
    Then it should be shown on the main page

