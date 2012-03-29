Feature: Testing Authlogic Signup and Login Logout

@model
Scenario: Logging in
  Given the following clerk exists:
    | login    | password   | password_confirmation |
    | Tony     | pass       | pass                  |
  When I log in as "Tony" with password "pass"
  Then the current clerk's login should be "Tony"
  
Scenario: Logging in through the user interface
  Given the following clerk exists:
        | login    | password   | password_confirmation |
        | John     | pass       | pass                  |
    And I am on the login page
    And I fill in the following:
        | Login     | John       |
        | Password  | pass       |
    When I press "Login"
    Then I should be on the home page
    And the current clerk's login should be "John"
    
Scenario: Getting to the Login page from the root url
  Given I am on the root page
  Then I should see "Login"
  When I follow "Login"
  Then I should be on the login page

Scenario: Signing up
    Given there are no clerks
    And I am on the new clerk page
    And I fill in the following:
        | Login                 | Sally      |
        | Password              | newpass    |
        | Password confirmation | newpass    |
    When I press "Submit"
    Then a new Clerk account for "Sally" should be created
    And the current clerk's login should be "Sally"
    And I am on the root page
    
