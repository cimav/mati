class CreateItemTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_types do |t|
      t.string :name
      t.string :logo
      t.references :item_type

      t.timestamps
    end
  end
end
