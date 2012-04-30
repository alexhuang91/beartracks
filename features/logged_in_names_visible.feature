Feature: Logged In Clerks and Residents Will see their name in the page header when logged in

Background:
Given the following clerks exist:
   | login    | password  | password_confirmation | unit   | first_name | last_name | is_admin | email            |
   | admin    | admin     | admin                 | Unit 1 | admin      | admin     | true     | admin@admin.com  |
   | paul     | pass      | pass                  | Unit 2 | Paul       | McCartney | true     | paul@beatles.com |
Given the following resident exists:
    | login    | password   | password_confirmation | email   |
    | Tony     | pass       | pass                  | j@j.com |

Scenario: When clerk is logged in their name will be visible in page header
    Given I am on the clerk login page
    And I fill in the following:
        | Login     | paul       |
        | Password  | pass       |
    When I press "Login"
    Then I should see "Paul McCartney"
    