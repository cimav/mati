class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.references :ticket
      t.integer    :rating
      t.text       :comments
      t.timestamps
    end
  end
end
