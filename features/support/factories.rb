Factory.define :clerk do |c|
  c.login {Factory.next(:login)}
  c.password "pass"
  c.password_confirmation "pass"
end