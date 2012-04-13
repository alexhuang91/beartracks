class AddClerkNames < ActiveRecord::Migration
  
  def change
    add_column :clerks, :first_name, :string
    add_column :clerks, :last_name, :string
  end

end
