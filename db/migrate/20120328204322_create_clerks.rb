class CreateClerks < ActiveRecord::Migration
  def change
    create_table :clerks do |t|
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.timestamps
    end
  end
end
