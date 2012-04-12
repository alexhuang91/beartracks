Feature: Clerks can edit their profile
  
Scenario: Should not see edit profile link when no clerk logged in
  Given there is no clerk logged in
  And I am on the root page
  Then I should not see "Edit Profile"
  
Scenario: Should see edit profile link when clerk is logged in and be able to edit profile
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
  And I should see "Edit Clerk Info"
  And I fill in the following:
    | Login    | Paul |
  When I press "Submit"
  Then the current clerk's login should be "Paul"
  And I should be on the clerk show page for Paul