Feature: Checkin
  In order to participate in a tounrnament
  As a player
  I want to check in

  Scenario: signed up user wants to check in
    Given I am signed up for a tournament
    And I am on that tournament page
    When I click on "check in"
    Then I should see "You have successfuly checked in."
  
  
  
