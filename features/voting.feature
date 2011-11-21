Feature: Voting
  In order to gain reputation
  As a user
  I want to vote on other people's comments

  Scenario: user tries to vote on a comment
    Given I have a post
    And I have a comment on that post
    And I am logged in as a different user
    And I am on the post page
    When I click on "upvote" within the "comment"
    Then I the comment score should raise
    And the comment author should get points

