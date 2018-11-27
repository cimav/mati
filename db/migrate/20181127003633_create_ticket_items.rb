class CreateTicketItems < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_items do |t|
      t.references :ticket
      t.references :item
      t.timestamps
    end
  end
end
