class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.integer    :consecutive
      t.string     :identificator
      t.references :agent
      t.references :people
      t.text       :description
      t.text       :cause
      t.text       :impact
      t.text       :symptom
      t.text       :solution
      t.integer    :status
      t.integer    :priority
      t.timestamps
    end
  end
end
