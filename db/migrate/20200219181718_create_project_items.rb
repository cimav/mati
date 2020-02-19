class CreateProjectItems < ActiveRecord::Migration[5.2]
  def change
    create_table :project_items do |t|
      t.references :project
      t.references :item
      t.timestamps
    end
  end
end
