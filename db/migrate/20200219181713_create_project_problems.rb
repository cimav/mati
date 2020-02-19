class CreateProjectProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :project_problems do |t|
      t.references :project
      t.references :problem
      t.timestamps
    end
  end
end
