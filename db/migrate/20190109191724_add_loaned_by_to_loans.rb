class AddLoanedByToLoans < ActiveRecord::Migration[5.2]
  def change
  	 add_column :loans, :loaned_by, :integer
  end
end
