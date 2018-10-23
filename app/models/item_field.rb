class ItemField < ApplicationRecord
  belongs_to :item_type
  TYPE_TEXT = 'TEXT'
end
