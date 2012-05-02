class SplitPackageName < ActiveRecord::Migration
  def up
    add_column :packages, :resident_first_name, :string
    add_column :packages, :resident_last_name, :string
    change_column :packages, :resident_name, :string, :null => true
    end

  def down
    remove_column :packages, :resident_first_name, :string
    remove_column :packages, :resident_last_name, :string
    change_column :packages, :resident_name, :string, :null => false
    end
end
