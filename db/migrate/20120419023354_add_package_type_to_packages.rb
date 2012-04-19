class AddPackageTypeToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :package_type, :string, :null => false, :default => "Other"
  end
end
