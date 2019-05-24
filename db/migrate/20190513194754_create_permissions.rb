class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.references :item
      t.references :person 
      t.text       :notes
      t.timestamps
    end
  end
end
