class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.references :agent
      t.string     :element_type
      t.integer    :element_id
      t.text       :message
      t.timestamps
    end
  end
end
