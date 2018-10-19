class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :contact
      t.string :email
      t.string :phone
      t.string :url
      t.text   :description
      t.text   :address
      
      t.timestamps
    end
  end
end
