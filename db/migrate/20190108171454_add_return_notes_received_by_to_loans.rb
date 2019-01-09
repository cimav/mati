class AddReturnNotesReceivedByToLoans < ActiveRecord::Migration[5.2]
  def change
  	add_column :loans, :received_by, :integer
  	add_column :loans, :received_date, :date
  	add_column :loans, :return_notes, :text
  end
end
