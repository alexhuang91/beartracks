Feature: Only admin clerks can create other clerks or view edit other clerk info

As an Admin Clerk
I want to be able to create other clerks, admin or not
So that I don't have to do all the work

Background: Clerks Exist in DB to play with

Given the following clerks exist:
   | login    | password   | password_confirmation | unit   | first_name | last_name | is_admin | email            |
   | admin    | admin      | admin                 | Unit 1 | admin      | admin     | true     | admin@admin.com  |
   | john     | pass       | pass                  | Unit 1 | John       | Lennon    | false    | john@beatles.com |
   
@model   
Scenario: Admin Clerk can See Add Clerk Button on Page Header
  And I am on the clerk login page
  And I fill in the following:
      | Login     | admin       |
      | Password  | admin       |
  When I press "Login"
  Then the current clerk's login should be "admin"
  Then the current clerk should be an admin
  Then I should see "Add New Clerk"
  
@model
Scenario: Regular Clerk can not see Add clerk button on page header
  And I am on the clerk login page
  And I fill in the following:
      | Login     | john       |
      | Password  | pass       |
  When I press "Login"
  Then the current clerk should not be an admin
  Then I should not see "Add New Clerk"