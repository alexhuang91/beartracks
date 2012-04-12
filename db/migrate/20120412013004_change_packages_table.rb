class ChangePackagesTable < ActiveRecord::Migration
  def up
    change_table :packages do |t|
      t.remove :tracking_number
      t.remove :room
      t.string :tracking_number
      t.string :room
    end
  end

  def down
    change_table :packages do |t|
      t.remove :tracking_number
      t.remove :room
      t.integer :tracking_number
      t.integer :room
    end
  end
end
