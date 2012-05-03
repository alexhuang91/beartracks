class AddPerishableTokenToClerks < ActiveRecord::Migration
  def change
    add_column :clerks, :perishable_token, :string, :default => "", :null => false 
  end
end
