class ChangeClerkUnitToNotBeNull < ActiveRecord::Migration
  def up
    change_column :clerks, :unit, :string, :null => false
  end

  def down
    change_column :clerks, :unit, :string
  end
end
