class AddStatusCostToContracts < ActiveRecord::Migration[5.2]
  def change
  	add_column :contracts, :cost, :decimal, :precision => 8, :scale => 2
    add_column :contracts, :status, :integer
  end
end
