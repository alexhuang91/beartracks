Feature: Clerks can edit their profile
  
Background: Create Clerk
  Given the following clerk exists:
        | login    | password   | password_confirmation | unit   | email           | first_name | last_name |
        | John     | pass       | pass                  | Unit 1 | john@lennon.com | John       | Lennon    |

Scenario: Should not see edit profile link when no clerk logged in
  Given there is no clerk logged in
  And I am on the root page
  Then I should not see "Edit Profile"
  
Scenario: Should see edit profile link when clerk is logged in and be able to edit profile
  Given I am on the clerk login page
  And I fill in the following:
      | Login     | John       |
      | Password  | pass       |
  And I press "Login"
  Then I should see "Edit Profile"
  When I follow "Edit Profile"
  Then I should be on the clerk edit page for John
  And I should see "Edit clerk info"
  And I fill in the following:
    | Login    | Paul |
  When I press "Update"
  Then the current clerk's login should be "Paul"
  And I should be on the clerk show page for Paul
  
Scenario: Attempt to Edit With Errors
  Given I am on the clerk login page
  And I fill in the following:
      | Login     | John       |
      | Password  | pass       |
  And I press "Login"
  When I follow "Edit Profile"
  And I fill in the following:
    | Email | alex |
  When I press "Update"
  Then I should be on the clerk edit page for John
  And I should see "the following errors"
  
Scenario: Logout and redirect to home after editing the password
  Given I am on the clerk login page 
  And I fill in the following:
      | Login     | John       |
      | Password  | pass       |
  And I press "Login"
  When I follow "Edit Profile"
  And I fill in the following:
    | Password 				| alex |
    | Password confirmation | alex |
  When I press "Update"
  Then I should be on the home page
  And I should see "Your password was changed. Please log in again."
  
