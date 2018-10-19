class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string     :name
      t.string     :number
      t.references :contract_type
      t.text       :description
      t.datetime   :start_date
      t.datetime   :end_date
      t.integer    :notify_days
      t.string     :notify_to
      t.timestamps
    end
  end
end
