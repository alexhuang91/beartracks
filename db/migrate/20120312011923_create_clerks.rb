class CreateClerks < ActiveRecord::Migration
  def change
    create_table :clerks do |t|

      t.timestamps
    end
  end
end
