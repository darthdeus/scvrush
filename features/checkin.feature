Feature: Checkin
  Users should be able to sign up and check in for a tournament
  
  Scenario Outline: user tries to check in too early
    Given I have a tournament starting in <time>
    And I am on that tournament page
    Then I should not be able to check in
    
  Examples:
    | time       |
    | 25 hours   |
    | 24 hours   |
    | 23 hours   |
    | 2 hours    |
    | 1 hour     |
    | 20 minutes |

    
  Scenario: user tries to check in within the checkin time
    Given I have a tournament starting in 10 minutes
    And I am on that tournament page
    Then I should be able to check in

  Scenario: user tries to sign up in time
    Given I have a tournament starting in 30 minutes
    And I am on that tournament page
    Then I should be able to sign up
    
  Scenario: user tries to sign up too late
    Given I have a tournament starting in 10 minutes
    And I am on that tournament page
    Then I should not be able to sign up    
  
  Scenario: user who didn't register tries to check in
    Given I have a tournament starting in 10 minutes
    And I am on that tournament page
    Then I should not be able to check in
  
  
  
  