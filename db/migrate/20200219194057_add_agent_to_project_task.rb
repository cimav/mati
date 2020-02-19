class AddAgentToProjectTask < ActiveRecord::Migration[5.2]
  def change
  	add_column :project_tasks, :agent_id, :integer

  end
end
