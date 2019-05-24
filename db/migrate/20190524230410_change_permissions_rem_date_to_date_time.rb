class ChangePermissionsRemDateToDateTime < ActiveRecord::Migration[5.2]
  def change
  	change_column :permissions, :removed_date, :datetime
  end
end
