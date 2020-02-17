class CreateChangeProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :change_problems do |t|
      t.references :change
      t.references :problem
      t.timestamps
    end
  end
end
