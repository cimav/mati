class CreateProjectTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tasks do |t|
      t.references :project
      t.date       :start_date
      t.date       :due_date
      t.string     :description
      t.integer    :status
      t.timestamps
    end
  end
end
