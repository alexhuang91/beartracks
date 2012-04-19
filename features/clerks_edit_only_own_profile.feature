Feature: Clerks can only edit their own profile page

As a clerk
So I can change my login information, and prevent other clerks from changing my info
I want to be able to edit profile

Background:

Given the following clerks exist:
   | login    | password  | password_confirmation | unit   | first_name | last_name | is_admin | email            |
   | paul     | pass      | pass                  | Unit 1 | Paul       | McCartney | false    | admin@admin.com  |
   | john     | pass      | pass                  | Unit 1 | John       | Lennon    | false    | john@beatles.com |
   
Scenario: A clerk can visit his own edit page
  Given I am on the clerk login page
  And I fill in the following:
      | Login     | john       |
      | Password  | pass       |
  And I press "Login" 
  When I go to the clerk edit page for john
  Then I should be on the clerk edit page for john
  
Scenario: A clerk cannot visit the edit page of another clerk
  Given I am on the clerk login page
  And I fill in the following:
    | Login     | john       |
    | Password  | pass       |
  And I press "Login"
  When I go to the clerk edit page for paul
  Then I should be on the clerk home page
  And I should see "you don't have access"
