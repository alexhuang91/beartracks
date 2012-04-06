Factory.sequence :login do |n|
  "login_#{n}"
end

Factory.sequence :email do |n|
  "email_#{n}@email.com"
end

Factory.define :clerk_session do |sesh|
  sesh.login "login"
  sesh.password "password"
  sesh.remember_me false
end

Factory.define :resident_session do |sesh|
  sesh.login "login"
  sesh.password "password"
  sesh.remember_me false
end

Factory.define :clerk do |c|
  c.login {Factory.next(:login)}
  c.password "pass"
  c.password_confirmation "pass"
end

Factory.define :resident do |r|
  r.login {Factory.next(:login)}
  r.email {Factory.next(:email)}
  r.password "pass"
  r.password_confirmation "pass"
end