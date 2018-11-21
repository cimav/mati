class AddPersonIdToPerson < ActiveRecord::Migration[5.2]
  def change
  	rename_column :people, :people_id, :person_id

  end
end
