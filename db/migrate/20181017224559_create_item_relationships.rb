class CreateItemRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :item_relationships do |t|
      t.references :relationship, foreign_key: true
      t.integer :parent_id
      t.integer :child_id
      t.timestamps
    end
  end
end
