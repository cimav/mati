class AddIdentificatorToTicket < ActiveRecord::Migration[5.2]
  def change
  	add_column :tickets, :identificator, :string
    add_column :tickets, :consecutive, :integer
  end
end
