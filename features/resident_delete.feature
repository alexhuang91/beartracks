Feature: Testing Resident Deletion

Background: I am logged in as a user and I look at my settings
  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name |
    | Tony  | pass     | pass                  | j@j.com | Unit 3 | Priestly | 202  | Email      | Nottony         | Pizzaman  |
  And I am on the resident login page
  When I log in as a resident through the UI with login "Tony" and password "pass"
  When I follow "My Profile"

@model
Scenario: Successful Delete
  When I follow "Delete My Account"
  Then I should be on the home page
  And I should see "Your account has been successfully deleted."
  Then there should be no resident logged in
  Then there are no residents
