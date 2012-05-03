class ChangeResidentNameFieldToNickName < ActiveRecord::Migration
  def change
    rename_column :residents, :name, :nickname
  end
end
