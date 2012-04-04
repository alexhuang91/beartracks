Factory.define :clerk do |c|
  c.login {Factory.next(:login)}
  c.password "pass"
  c.password_confirmation "pass"
end
Factory.define :resident do |r|
  r.login {Factory.next(:login)}
  r.password "pass"
  r.password_confirmation "pass"
end
