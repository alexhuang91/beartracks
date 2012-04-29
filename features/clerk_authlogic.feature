Feature: Testing Authlogic Clerk Signup and Login Logout

@model
Scenario: Logging in and logging out
  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | email            | first_name | last_name |
    | Paul     | pass       | pass                  | Unit 1 | paul@beatles.com | Paul       | McCartney |
  When I log in as a clerk with username "Paul" and password "pass"
  Then the current clerk's login should be "Paul"
  When I log out clerk
  Then there should be no clerk logged in
  
Scenario: Logging in and out through the user interface
  Given the following clerk exists:
        | login    | password   | password_confirmation | unit   | email           | first_name | last_name |
        | John     | pass       | pass                  | Unit 1 | john@lennon.com | John       | Lennon    |
    And I am on the clerk login page
    Then I should not see "Logout"
    And I fill in the following:
        | Login     | John       |
        | Password  | pass       |
    When I press "Login"
    Then I should be on the packages page
    And the current clerk's login should be "John"
    Then I should see "You have successfully logged in."
    Then I should see "Logout"
    Then I should not see "Clerk Login"
    
Scenario: Visiting the logout url with no user logged in
  Given there is no clerk logged in
  Given I am on the clerk logout page
  Then I should be on the root page
  And I should not see "You have successfully logged out."
    
Scenario: Getting to the Login page from the root url
  Given I am on the root page
  Then I should see "Clerk Login"
  When I follow "Clerk Login"
  Then I should be on the clerk login page

Scenario: Admin Clerk Signs Up a new normal Clerk
    Given the following clerk exists:
          | login | password | password_confirmation | unit   | email           | first_name | last_name | is_admin |
          | admin | admin    | admin                 | Unit 1 | john@lennon.com | John       | Lennon    | true     |
    And I am on the clerk login page
    And I fill in the following:
        | Login     | admin   |
        | Password  | admin    |
    When I press "Login"
    Then the current clerk's login should be "admin"
    And I go to the new clerk page
    And I fill in the following:
        | Login                 | Sally          |
        | First name            | Sally          |
        | Last name             | Fields         |
        | Password              | newpass        |
        | Password confirmation | newpass        |
        | Email                 | sally@mail.com |
    When I press "Create Clerk"
    Then a new Clerk account for "Sally" should be created
    And the current clerk's login should be "admin"
    Then I should be on the clerks page

  
  
  
    
