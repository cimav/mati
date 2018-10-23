class ItemType < ApplicationRecord
  belongs_to :item_type
  has_many :item_fields
end
