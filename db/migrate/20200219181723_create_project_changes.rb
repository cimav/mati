class CreateProjectChanges < ActiveRecord::Migration[5.2]
  def change
    create_table :project_changes do |t|
      t.references :project
      t.references :change
      t.timestamps
    end
  end
end
