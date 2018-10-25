class ChangeTypeAgent < ActiveRecord::Migration[5.2]
  def change
  	rename_column :agents, :type, :agent_type
  end
end
