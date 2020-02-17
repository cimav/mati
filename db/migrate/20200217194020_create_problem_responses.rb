class CreateProblemResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_responses do |t|
      t.references :problem
      t.integer    :from
      t.integer    :to 
      t.text       :message
      t.timestamps
    end
  end
end
