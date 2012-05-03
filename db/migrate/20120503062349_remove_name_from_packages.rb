class RemoveNameFromPackages < ActiveRecord::Migration
  def change
	remove_column :packages, :resident_name, :string
  end
end
