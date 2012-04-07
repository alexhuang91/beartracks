class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :tracking_number, :null => false, :unique => true
      t.string :carrier
      t.text :description

      t.string :resident_name, :null => false
      t.integer :resident_id
      t.string :unit, :null => false
      t.string :building, :null => false
      t.integer :room, :null => false

      t.integer :clerk_received_id
      t.integer :clerk_accepted_id
     
      t.string :sender_address
      t.string :sender_city
      t.string :sender_state
      t.integer :sender_zip
      
      t.datetime :datetime_received, :null => false
      t.datetime :datetime_accepted
      t.datetime :updated_at
      t.boolean :picked_up, :null => false, :default => false
    end
  end
end
