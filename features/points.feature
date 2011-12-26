Feature: points
  In order to be recognized in the community
  As a user
  I want to gain points

  Scenario: someone upvotes on my comment
    Given I have a comment
    When somebody upvotes on that comment
    Then I should get 1 point

  Scenario: upvote on forum reply
    Given I have a post reply
    When somebody upvotes on that reply
    Then I should get 1 point

  Scenario: points for login
    When I log in for the first time
    Then I should get 1 point

  Scenario: no points for additional login
    When I log in for the second time
    Then I my points should not change

  Scenario: 10 replies on a topic
    Given I have started a topic
    When the topic gets 10 replies
    Then I should get 3 points

