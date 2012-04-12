Feature: Testing Authlogic Resident Signup and Login Logout

@model
Scenario: Logging in and logging out
  Given the following resident exists:
    | login    | password   | password_confirmation | email   |
    | Tony     | pass       | pass                  | j@j.com |
  When I log in as a resident with username "Tony" and password "pass"
  Then the current resident's login should be "Tony"
  When I log out resident
  Then there should be no resident logged in
  
Scenario: Logging in and out through the user interface
  Given the following resident exists:
        | login    | password   | password_confirmation | email   |
        | John     | pass       | pass                  | j@j.com |
    And I am on the resident login page
    Then I should not see "Logout"
    And I fill in the following:
        | Login     | John       |
        | Password  | pass       |
    When I press "Login"
    Then I should be on the home page
    And the current resident's login should be "John"
    Then I should see "You have successfully logged in."
    Then I should see "Logout"
    Then I should not see "Resident Login"
    When I follow "Resident Logout"
    Then I should see "You have successfully logged out."

Scenario: Visiting the logout url with no user logged in
  Given there are no residents
  Given I am on the resident logout page
  Then I should be on the root page
  And I should not see "You have successfully logged out."
    
Scenario: Getting to the Login page from the root url
  Given I am on the root page
  Then I should see "Resident Login"
  When I follow "Resident Login"
  Then I should be on the resident login page

Scenario: Signing up
    Given there are no residents
    And I am on the new resident page
    And I fill in the following:
        | Login                 | Sally      |
        | Password              | newpass    |
        | Password confirmation | newpass    |
        | Email                 | a@b.com    |
    When I press "Submit"
    Then a new resident account for "Sally" should be created
    And the current resident's login should be "Sally"
    And I am on the root page
