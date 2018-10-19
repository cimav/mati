class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :email
      t.string :phone
      t.string :department
      t.references :people
      t.string :timezone
      t.references :location
      t.timestamps
    end
  end
end
