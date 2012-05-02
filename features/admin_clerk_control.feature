Feature: Admin clerks can create other clerks, view all clerks, and toggle admin access for clerks

As an Admin Clerk
I want to be able to create other clerks and make them admins
So that I don't have to do all the work

Background: Clerks Exist in DB to play with

Given the following clerks exist:
   | login    | password  | password_confirmation | unit   | first_name | last_name | is_admin | email            |
   | admin    | admin     | admin                 | Unit 1 | admin      | admin     | true     | admin@admin.com  |
   | paul     | pass      | pass                  | Unit 2 | Paul       | McCartney | true     | paul@beatles.com |
   | john     | pass      | pass                  | Unit 1 | John       | Lennon    | false    | john@beatles.com |
   
Scenario: Admin Clerk can See Add Clerk Button on Page Header and navigate to the new clerk page
  When I log in as a clerk through the UI with login "admin" and password "admin"
  Then the current clerk's login should be "admin"
  Then the current clerk should be an admin
  Then I should see "Add New Clerk"
  When I follow "Add New Clerk"
  Then I should be on the new clerk page
  
Scenario: Regular Clerk can not see Add clerk button on page header nor navigate to the clerk create page
  When I log in as a clerk through the UI with login "john" and password "pass"
  Then the current clerk should not be an admin
  Then I should not see "Add New Clerk"
  When I go to the new clerk page
  Then I should be on the clerk home page
  
Scenario: Admin clerk can create a new clerk
  When I log in as a clerk through the UI with login "admin" and password "admin"
  Given I am on the new clerk page
  Then I should see "Create a new clerk"
  When I fill in the following:
  	  | Login				  | newclerk |
  	  | First name			  | new		 |
  	  | Last name			  | clerk    |
  	  | Password			  | pass	 |
  	  | Password confirmation | pass 	 |
  	  | Email				  | n@c.com  |
  And I press "Create Clerk"
  Then I should be on the clerks page 
  And I should see "Clerk account successfully created."
  And I should see "newclerk"

Scenario: Admin clerk can see a list of all Clerks
  When I log in as a clerk through the UI with login "admin" and password "admin"
  Given I am on the clerks page
  Then I should see "admin"
  And I should see "john"
  And I should see "paul"
  And I should see "Yes"
  And I should see "No"
  
Scenario: Admin clerk can grant admin privileges to a regular clerk
  When I log in as a clerk through the UI with login "admin" and password "admin"
  Given I am on the clerks page
  Then I should see "grant admin privileges"
  When I follow "grant admin privileges"
  Then I should be on the clerks page
  And I should see "John Lennon has been granted admin privileges."

Scenario: Admin clerk can revoke admin privileges of another admin clerk
  When I log in as a clerk through the UI with login "admin" and password "admin"
  Given I am on the clerks page
  Then I should see "revoke admin privileges"
  When I follow "revoke admin privileges"
  Then I should be on the clerks page
  And I should see "Paul McCartney has lost admin privileges."
