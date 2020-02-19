class ChangePersonPeopleProject < ActiveRecord::Migration[5.2]
  def change
  	rename_column :projects, :people_id, :person_id
  end
end
