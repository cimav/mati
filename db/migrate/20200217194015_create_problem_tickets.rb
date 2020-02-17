class CreateProblemTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_tickets do |t|
      t.references :problem
      t.references :ticket
      t.timestamps
    end
  end
end
