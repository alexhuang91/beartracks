Feature: Admins can edit a clerk's profile, but not other admin's profiles.
  
Background: Create Clerk
  Given the following clerks exist:
        | login    | password   | password_confirmation | unit   | email           | first_name | last_name | is_admin |
        | Steve    | pass       | pass                  | Unit 1 | stve@lennon.com | Steve      | Jobs      |   true   |
        | Dave     | pass       | pass                  | Unit 1 | dave@lennon.com | Dave       | Lennox    |   true   |
        | John     | pass       | pass                  | Unit 1 | john@lennon.com | John       | Lennon    |   false  |

Scenario: Should not see edit profile link when no clerk logged in
  Given there is no clerk logged in
  And I am on the root page
  Then I should not see "Edit Profile"

Scenario: A clerk should not see the edit profile link
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "John" and password "pass"
  Then I should not see "Edit Profile"
 
Scenario: A clerk should not be able to edit his/her own profile
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "John" and password "pass"
  And I am on the clerk edit page for John
  Then I should be on the clerk home page
  And I should see "You can't edit your own profile. Please ask your supervisor."
  
Scenario: Should see edit profile link when admin is logged in and be able to edit profile
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "Dave" and password "pass"
  Then I should see "Edit Profile"
  When I follow "Edit Profile"
  Then I should be on the clerk edit page for Dave
  And I should see "Edit clerk info"
  And I fill in the following:
    | Login    | Paul |
  When I press "Update"
  Then the current clerk's login should be "Paul"
  And I should be on the clerk show page for Paul
  
Scenario: Admin can edit a clerk's information
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "Dave" and password "pass"
  And I am on the clerk edit page for John
  Then I should see "Edit clerk info"
  And I fill in the following:
    | Login    | Paul |
  When I press "Update"
  Then I should be on the clerk show page for Paul
  
Scenario: Admin cannot edit another admin's profile
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "Dave" and password "pass"
  And I am on the clerk edit page for Steve
  Then I should be on the clerks page
  And I should see "You can't edit another admin's profile."  

Scenario: Attempt to Edit With Errors
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "Dave" and password "pass"
  When I follow "Edit Profile"
  And I fill in the following:
    | Email | alex |
  When I press "Update"
  Then I should be on the clerk edit page for Dave
  And I should see "the following errors"
  
Scenario: Logout and redirect to home after editing the password
  Given I am on the clerk login page
  And I log in as a clerk through the UI with login "Dave" and password "pass"
  When I follow "Edit Profile"
  And I fill in the following:
    | Password 				| alex |
    | Password confirmation | alex |
  When I press "Update"
  Then I should be on the home page
  And I should see "Your password was changed. Please log in again."
  
