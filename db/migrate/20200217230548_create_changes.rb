class CreateChanges < ActiveRecord::Migration[5.2]
  def change
    create_table :changes do |t|
      t.integer    :consecutive
      t.string     :identificator
      t.references :agent
      t.references :people
      t.text       :description
      t.text       :reason
      t.text       :impact
      t.text       :rollout_plan
      t.text       :backout_plan
      t.integer    :change_type
      t.integer    :risk_type
      t.date       :start_date_planned
      t.date       :end_date_planned
      t.date       :start_date_real
      t.date       :end_date_real
      t.integer    :status
      t.integer    :priority
      t.timestamps
    end
  end
end
