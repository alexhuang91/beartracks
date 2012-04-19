class ChangeResidentRoomDataType < ActiveRecord::Migration
  def up
    change_table :residents do |t|
      t.change :room, :string
    end
  end

  def down
    change_table :residents do |t|
      t.change :room, :integer
    end
  end
end
