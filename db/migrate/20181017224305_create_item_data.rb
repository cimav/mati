class CreateItemData < ActiveRecord::Migration[5.2]
  def change
    create_table :item_data do |t|
      t.references :item
      t.references :item_field
      t.text :value
      
      t.timestamps
    end
  end
end
