Feature: Testing Authlogic

@model
Scenario: Logging in
  Given the following clerk exists:
    | login    | password   | password_confirmation |
    | Tony     | pass       | pass                  |
  When I log in as "Tony" with password "pass"
  Then the current clerk's login should be "Tony"
  
Scenario: Signing up
    Given there are no clerks
    And I am on the new clerk page
    And I fill in the following:
        | Login                 | Sally      |
        | Password              | newpass    |
        | Password confirmation | newpass    |
    When I press "Create"
    Then a new Clerk account for "Sally" should be created
    And the current clerk's login should be "Sally"