class ChangeLoansPerson < ActiveRecord::Migration[5.2]
  def change
  	rename_column :loans, :people_id, :person_id
  end
end
