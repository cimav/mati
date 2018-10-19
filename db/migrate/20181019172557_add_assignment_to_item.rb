class AddAssignmentToItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :items,:location_id,:integer
  	add_column :items,:department_id,:integer
  	add_column :items,:used_by,:integer
  	add_column :items,:managed_by,:integer
  	add_column :items,:assigned_on,:datetime
  end
end
