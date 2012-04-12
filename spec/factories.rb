FactoryGirl.define do
  
  sequence :login do |n| 
    "login_#{n}"
  end
  sequence :email do |n|
    "email_#{n}@email.com"
  end
  
  factory :clerk_session do
    login "login"
    password "password"
    remember_me false
  end
  
  factory :resident_session do
    login "login"
    password "password"
    remember_me false
  end

  factory :clerk do
    login {FactoryGirl.generate(:login)}
    email {FactoryGirl.generate(:email)}
    is_admin false
    unit "Unit 1"
    password "pass"
    password_confirmation "pass"
  end

  factory :resident do
    login {FactoryGirl.generate(:login)}
    email {FactoryGirl.generate(:email)}
    password "pass"
    password_confirmation "pass"
  end

  factory :package do
    resident_name "Name"
    resident_id 1
    unit "Unit"
    building "Building"
    room "Room"
    tracking_number "12345"
    datetime_received Time.now-500
    updated_at Time.now
    datetime_accepted nil
    sender_city "City"
    sender_state "CA"
    sender_address "123 Big Street"
    sender_zip "90210"
    picked_up false
    carrier "Mail Motherfucker"
    clerk_received_id 10
    clerk_accepted_id nil
    clerk_id 12
    description "Good Words"
  end
end
