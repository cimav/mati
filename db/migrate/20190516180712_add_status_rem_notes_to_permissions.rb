class AddStatusRemNotesToPermissions < ActiveRecord::Migration[5.2]
  def change
  	add_column :permissions, :status, :integer
    add_column :permissions, :removed_date, :date
    add_column :permissions, :removed_notes, :text
  end
end
