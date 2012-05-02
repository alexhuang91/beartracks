Feature: Logged In Clerks and Residents Will see their name in the page header when logged in

Background:
Given the following clerks exist:
   | login    | password  | password_confirmation | unit   | first_name | last_name | is_admin | email            |
   | admin    | admin     | admin                 | Unit 1 | admin      | admin     | true     | admin@admin.com  |
   | paul     | pass      | pass                  | Unit 2 | Paul       | McCartney | true     | paul@beatles.com |
Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building    | room | preference | first_name      | last_name | name    |
    | Alex  | pass     | pass                  | j@j.com | Unit 3 | Spens-Black | 202  | Email      | Alex            | Huang     |         |
    | Kevin | pass     | pass                  | a@a.com | Unit 2 | Cheney      | 101  | Mail Slip  | Kevin           | Sheng     | Kevdawg |

Scenario: When clerk is logged in their name will be visible in page header
    Given I am on the clerk login page
    And I fill in the following:
        | Login     | paul       |
        | Password  | pass       |
    When I press "Login"
    Then I should see "Paul McCartney"
   
Scenario: When resident is logged in (no nick), their name will be visible in page header
  Given I am on the resident login page
  And I fill in the following:
    | Login    | Alex |
    | Password | pass |
  When I press "Login"
  Then I should see "Alex"

Scenario: When resident is logged in (w/ nick), their nickname will be visible in page header
  Given I am on the resident login page
  And I fill in the following:
    | Login    | Kevin |
    | Password | pass  |
  When I press "Login"
  Then I should see "Kevdawg"
  Then I should not see "Kevin"
