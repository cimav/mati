class AddDatesToTask < ActiveRecord::Migration[5.2]
  def change
  	add_column :project_tasks, :doing_date, :datetime
  	add_column :project_tasks, :done_date, :datetime
  end
end
