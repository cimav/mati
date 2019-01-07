class Loan < ApplicationRecord
  belongs_to :item
  belongs_to :people, optional: true
  
  LOANED = 1
  RETURNED = 2
end
