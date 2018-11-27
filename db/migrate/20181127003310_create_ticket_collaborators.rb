class CreateTicketCollaborators < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_collaborators do |t|
      t.references :ticket
      t.references :agent
      t.timestamps
    end
  end
end
