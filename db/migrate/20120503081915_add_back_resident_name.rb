class AddBackResidentName < ActiveRecord::Migration
  def up
	add_column :packages, :resident_name, :string
  end

  def down
	remove_column :packages, :resident_name, :string
  end
end
