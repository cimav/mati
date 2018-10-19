class AddIdentificatorToItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :items,:identificator,:string
  	add_column :items,:impact,:integer
  end
end
