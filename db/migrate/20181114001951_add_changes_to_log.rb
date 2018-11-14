class AddChangesToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_logs, :changed_values, :text
  end
end
