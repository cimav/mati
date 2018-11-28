class ChangeTicketsPerson < ActiveRecord::Migration[5.2]
  def change
  	rename_column :tickets, :people_id, :person_id
  end
end
