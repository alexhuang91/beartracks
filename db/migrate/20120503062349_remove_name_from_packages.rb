class RemoveNameFromPackages < ActiveRecord::Migration
  def up
    remove_column :packages, :resident_name, :string
  end
  
  def down
    add_column :packages, :resident_name, :string
  end
end
