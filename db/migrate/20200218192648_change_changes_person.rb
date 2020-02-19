class ChangeChangesPerson < ActiveRecord::Migration[5.2]
  def change
        rename_column :changes, :people_id, :person_id
  end
end
