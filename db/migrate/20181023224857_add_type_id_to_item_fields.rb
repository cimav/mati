class AddTypeIdToItemFields < ActiveRecord::Migration[5.2]
  def change
  	add_column :item_fields,:item_type_id,:integer
  end
end
