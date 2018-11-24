class CreateContractItems < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_items do |t|
      t.references :contract
      t.references :item
      t.timestamps
    end
  end
end
