Feature: practice buddy
  In order to find a new practice partner
  As a SC 2 player
  I want to browser through players who have already signed up and contact them

  Scenario: user wants to opt in
    Given I am a regular user
    And I have my profile information complete
    When I go to the practice buddy page
    And I click on "Join"
    Then I should be listed

  Scenario: user wants to opt out
    Given I am a regular user
    And I have signed up for the practice buddy program
    When I go to my profile
    Then I should see "Opt out of practice buddy"
    When I opt out the practice buddy
    Then I should no longer be listed

  Scenario: user with incomplete info tries to opt in
    Given I am a regular user
    And I go to the practice buddy page
    When I click "Join"
    Then I should see "You have to fill in your profile information first"
    And I should be on my edit profile page
