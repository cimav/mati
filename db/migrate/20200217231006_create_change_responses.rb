class CreateChangeResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :change_responses do |t|
      t.references :change
      t.integer    :from
      t.integer    :to 
      t.text       :message
      t.timestamps
    end
  end
end
