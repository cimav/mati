class AddHasAccessControlsToItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :has_access_controls, :boolean
  end
end