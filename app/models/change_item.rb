class ChangeItem < ApplicationRecord
  belongs_to :change 
  belongs_to :item
end
