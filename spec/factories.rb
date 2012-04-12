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

end
