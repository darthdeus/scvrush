Feature: points
  In order to be recognized in the community
  As a user
  I want to gain points

  Scenario: someone upvotes on my comment
    Given I have a comment
    When somebody upvotes on that comment
    Then I should get 1 point

