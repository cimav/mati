class CreateChangeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :change_items do |t|
      t.references :change
      t.references :item
      t.timestamps
    end
  end
end
