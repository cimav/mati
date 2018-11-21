class AddFieldsToPerson < ActiveRecord::Migration[5.2]
  def change
  	add_column    :people, :last_name2, :string
    add_column    :people, :person_type, :string
    add_column    :people, :identificator, :string
  	change_column :people, :department, :integer
  	rename_column :people, :department, :department_id

  end
end
