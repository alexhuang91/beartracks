Feature: Residents can see the packages waiting for them

As a resident
I want to be able to view the packages I have received and waiting for me
So that I can see all past and current packages

Background: packages in database, resident logged in

  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name | last_name |
    | Alex  | pass     | pass                  | a@a.com | Unit 2 | Cheney   | 101  | Mail Slip  | Alex       | Great     |

  Then I log in as a resident through the UI with login "Alex" and password "pass"

  Given the following packages exist my way:
  | resident_first_name | resident_last_name | tracking_number | unit   | building | room | datetime_received | picked_up | clerk_id | resident_id |
  | Alex                | Great              | 123             | Unit 2 | Cheney   | 101  | 1977-05-25        | true      | 1        |       1	   |

Scenario: Resident should be able to see all packages waiting for them
  Given I am on the residents page
  Then I should see "123"
  And I should see "Yes"
  And I should see "Your packages"
