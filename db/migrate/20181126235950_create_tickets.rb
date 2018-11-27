class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.references :agent
      t.references :people
      t.references :service
      t.text       :description
      t.integer    :status
      t.integer    :priority
      t.timestamps
    end
  end
end
