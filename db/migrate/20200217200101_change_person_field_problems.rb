class ChangePersonFieldProblems < ActiveRecord::Migration[5.2]
  def change
  	rename_column :problems, :people_id, :person_id
  end
end
