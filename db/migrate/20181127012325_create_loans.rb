class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.references :people
      t.references :item
      t.text       :notes
      t.date       :return_date
      t.integer    :status
      t.timestamps
    end
  end
end
