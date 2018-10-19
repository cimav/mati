class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.references :people
      t.integer :type
      t.timestamps
    end
  end
end
