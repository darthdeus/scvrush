Feature: Raffle
  In order to give away free stuff
  As a site owner
  I want to pick a random user from the raffle list

  @wip
  Scenario: administrator wants to create a new raffle
    Given I am an administrator
    And I am on a new raffle page
    When I fill in name "Lorem ipsum"
    Then I should have a new raffle
  
  Scenario: user wants to join a raffle
    Given I have an open raffle
    And I am a regular user
    When I go to that raffle page
    Then I should be able to join
  
  Scenario: regular visitor tries to join the raffle
    Given I have an open raffle
    And I am not logged in
    When I go to that raffle page
    Then I should not be able to join
  
  Scenario: raffle is closed
    Given I have a closed raffle
    And I am a regular user
    When I go to that raffle page
    Then I should not be able to join

  Scenario: admin closes a raffle
    Given I have an open raffle
    And the raffle has a user registered
    And I am an administrator
    When I go to that raffle page
    And I close the raffle
    Then a winner should be selected
  
  
  