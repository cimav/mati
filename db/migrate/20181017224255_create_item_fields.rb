class CreateItemFields < ActiveRecord::Migration[5.2]
  def change
    create_table :item_fields do |t|
      t.string :name
      t.string :field_type
      t.text :values
      t.string :default
      t.integer :position
      
      t.timestamps
    end
  end
end
