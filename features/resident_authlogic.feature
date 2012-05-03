Feature: Testing Authlogic Resident Signup and Login Logout

@model
Scenario: Logging in and logging out
  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name |
    | Tony  | pass     | pass                  | j@j.com | Unit 3 | Priestly | 202  | Email      | Nottony         | Pizzaman  |
  When I log in as a resident with username "Tony" and password "pass"
  Then the current resident's login should be "Tony"
  When I log out resident
  Then there should be no resident logged in
  
Scenario: Logging in and out through the user interface
  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name |
    | John  | pass     | pass                  | j@j.com | Unit 3 | Priestly | 202  | Email      | Nottony         | Pizzaman  |
  And I am on the resident login page
  Then I should not see "Logout"
  When I log in as a resident through the UI with login "John" and password "pass"
  Then I should be on the residents page
  And the current resident's login should be "John"
  Then I should see "You have successfully logged in."
  Then I should see the "resident logout" link
  Then I should not see the "resident login" link
  When I follow the "resident logout" link
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
        | Login                 | Sally       |
        | Password              | newpass     |
        | Password Confirmation | newpass     |
        | Email                 | a@b.com     |
        | Room                  | 101         |
        | First Name            | Sally       |
        | Last Name             | Superwoman  |
    And I select "Unit 1" from "Unit"
    And I select "Cheney Hall" from "Building"
    When I press "Submit"
    Then a new resident account for "Sally" should be created
    And the current resident's login should be "Sally"
    And I am on the root page

Scenario: Redirect to home page after a resident changes his/her password
  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name |
    | Tony  | pass     | pass                  | j@j.com | Unit 3 | Priestly | 202  | Email      | Nottony         | Pizzaman  |
  Given I am on the resident login page 
  When I log in as a resident through the UI with login "Tony" and password "pass"
  Given I am on the resident edit page for resident 1
  And I fill in the following:
    | resident_password 		 	 | alex |
    | resident_password_confirmation | alex |
  When I press "Update"
  Then I should be on the home page
  And I should see "Your password was changed. Please log in again."
  
