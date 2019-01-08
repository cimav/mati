class Loan < ApplicationRecord
  belongs_to :item
  belongs_to :person
  has_many :activity_logs, as: :element
  
  LOANED = 1
  RETURNED = 2
end
