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
  
  @wip
  Scenario: user wants to join a raffle
    Given I have a raffle
    And the raffle is active
    When event
    Then outcome
  
  
  
  
  
