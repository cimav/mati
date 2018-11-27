class AddLoanableToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_loanable, :boolean
  end
end
