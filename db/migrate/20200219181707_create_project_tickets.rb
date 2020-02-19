class CreateProjectTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tickets do |t|
      t.references :project
      t.references :ticket
      t.timestamps
    end
  end
end
