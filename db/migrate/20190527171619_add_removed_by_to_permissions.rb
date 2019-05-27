class AddRemovedByToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :removed_by, :integer
  end
end
