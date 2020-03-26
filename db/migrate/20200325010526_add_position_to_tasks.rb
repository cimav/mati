class AddPositionToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :position, :integer
  end
end
