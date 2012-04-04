class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      ##Resident Information
      t.string :user_id
      t.string :name
      t.string :unit
      t.string :building
      t.integer :room
      t.string :preference
      t.integer :phone_number
      t.string :email

      t.timestamps
    end
  end
end
