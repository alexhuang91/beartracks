class RemoveClerkReceivedIdFromPackages < ActiveRecord::Migration
  def up
    remove_column :packages, :clerk_received_id
  end

  def down
    add_column :packages, :clerk_received_id, :integer
  end
end
