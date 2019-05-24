class AddAgentIdToPermissions < ActiveRecord::Migration[5.2]
  def change
  	add_column :permissions, :agent_id, :integer
  end
end
