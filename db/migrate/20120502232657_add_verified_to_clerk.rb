class AddVerifiedToClerk < ActiveRecord::Migration
  def change
    add_column :clerks, :verified, :boolean, :default => false 
  end
end
