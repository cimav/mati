class AddPersonToAgent < ActiveRecord::Migration[5.2]
  def change
  	rename_column :agents, :people_id, :person_id
  end
end
