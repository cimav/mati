class AddTokenToSurveys < ActiveRecord::Migration[5.2]
  def change
  	add_column :surveys, :token, :string
  end
end
