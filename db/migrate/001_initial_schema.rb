class InitialSchema < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :tracking_number, :null => false, :unique => true
      t.string :resident_name, :null => false
      t.integer :resident_id
      t.datetime :datetime_received, :null => false
      t.string :carrier
      t.string :unit, :null => false
      t.string :building, :null => false
      t.integer :room, :null => false
      t.integer :clerk_received_id
      t.integer :clerk_accepted_id
      t.datetime :datetime_accepted
      t.string :sender_address
      t.string :sender_city
      t.string :sender_state
      t.integer :sender_zip
      t.text :description
      t.datetime :updated_at
    end
  end
end
