class AddPersonToDepartment < ActiveRecord::Migration[5.2]
  def change
  	add_column :departments, :person_id, :integer
  end
end
