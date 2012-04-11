class AddFieldsToClerk < ActiveRecord::Migration
  def change
    add_column :clerks, :unit, :string
    add_column :clerks, :email, :string
    add_column :clerks, :is_admin, :boolean
  end
end
