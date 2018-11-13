class AddStatusToPeople < ActiveRecord::Migration[5.2]
  def change
  	add_column :people,:status,:integer
  	add_column :agents,:status,:integer
  end
end
