class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string     :name
      t.text       :description
      t.text       :address
      t.references :location
      t.timestamps
    end
  end
end
