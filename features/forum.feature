Feature: Forum

  @wip
  Scenario: user creates a new section
    Given I am a regular user
    When I submit a new topic
    Then I should see "Topic was successfuly created."

