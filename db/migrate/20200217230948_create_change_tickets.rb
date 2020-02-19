class CreateChangeTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :change_tickets do |t|
      t.references :change
      t.references :ticket
      t.timestamps
    end
  end
end
