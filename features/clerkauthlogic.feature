Feature: Testing Authlogic Clerk Signup and Login Logout

@model
Scenario: Logging in and logging out
  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | email           | 
    | Tony     | pass       | pass                  | Unit 1 | paul@beatles.com |
  When I log in as a clerk with username "Tony" and password "pass"
  Then the current clerk's login should be "Tony"
  When I log out clerk
  Then there should be no clerk logged in
  
Scenario: Logging in and out through the user interface
  Given the following clerk exists:
        | login    | password   | password_confirmation | unit   | email           | 
        | John     | pass       | pass                  | Unit 1 | john@lennon.com |
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
  Given there are no clerks
  Given I am on the clerk logout page
  Then I should be on the root page
  And I should not see "You have successfully logged out."
    
Scenario: Getting to the Login page from the root url
  Given I am on the root page
  Then I should see "Clerk Login"
  When I follow "Clerk Login"
  Then I should be on the clerk login page

Scenario: Signing up
    Given there are no clerks
    And I am on the new clerk page
    And I fill in the following:
        | Login                 | Sally          |
        | Password              | newpass        |
        | Password confirmation | newpass        |
        | Email                 | sally@mail.com |
    When I press "Submit"
    Then a new Clerk account for "Sally" should be created
    And the current clerk's login should be "Sally"
    Then I should be on the packages page
    
Scenario: Should not see edit profile link when no clerk logged in
  Given there is no clerk logged in
  And I am on the root page
  Then I should not see "Edit Profile"
  
Scenario: Should see edit profile link when clerk is logged in and be able to edit
  Given the following clerk exists:
        | login    | password   | password_confirmation | unit   | email           | 
        | John     | pass       | pass                  | Unit 1 | john@lennon.com |
  And I am on the clerk login page
  And I fill in the following:
      | Login     | John       |
      | Password  | pass       |
  And I press "Login"
  Then I should see "Edit Profile"
  When I follow "Edit Profile"
  Then I should be on the clerk edit page for John
  I should see "Edit Clerk Info"
  
  
  
    
