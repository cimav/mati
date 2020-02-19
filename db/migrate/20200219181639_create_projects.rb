class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer    :consecutive
      t.string     :identificator
      t.references :agent
      t.references :people
      t.text       :description
      t.date       :start_date_planned
      t.date       :end_date_planned
      t.date       :start_date_real
      t.date       :end_date_real
      t.integer    :priority
      t.integer    :status
      t.timestamps
    end
  end
end
