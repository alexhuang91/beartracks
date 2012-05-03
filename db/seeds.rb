# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
#   create an admin to be the base admin in the system for the dorm people
#   create another admin to be what our class uses for grading
#
  first_admin = Clerk.create( first_name: 'Master', last_name: 'Admin', login: 'admin',
      unit: 'Unit 1', password: 'pass', password_confirmation: 'pass', email: 'a@a.com' )
  first_admin.is_admin = true
  first_admin.verified = true
  first_admin.save

  class_admin = Clerk.create( first_name: 'Armando', last_name: 'Foxxymama', login: 'cs169_admin',
      unit: 'Unit 3', password: 'pass', password_confirmation: 'pass', email: 'b@b.com' )
  class_admin.is_admin = true
  class_admin.verified = true
  class_admin.save

  class_clerk = Clerk.create( first_name: 'David', last_name: 'Pattypatpat', login: 'cs169_clerk',
      unit: 'Unit 3', password: 'pass', password_confirmation: 'pass', email: 'c@c.com' )
  class_clerk.verified = true
  class_clerk.save
