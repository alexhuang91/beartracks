class AddReturnStatusToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :returned, :boolean, :null => false, :default => false
  end
end
