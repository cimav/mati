class CreateTicketResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_responses do |t|
      t.references :ticket
      t.integer    :from
      t.integer    :to 
      t.text       :message
      t.timestamps
    end
  end
end
