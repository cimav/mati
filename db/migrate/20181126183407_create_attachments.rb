class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.references :agent
      t.string     :element_type
      t.integer    :element_id
      t.string     :file
      t.timestamps
    end
  end
end
