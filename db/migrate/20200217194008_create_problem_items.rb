class CreateProblemItems < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_items do |t|
      t.references :problem
      t.references :item
      t.timestamps
    end
  end
end
