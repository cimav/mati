class ItemField < ApplicationRecord
  belongs_to :item_type
  TYPE_TEXT = 'TEXT'
  TYPE_TEXTAREA = 'TEXTAREA'
  TYPE_SELECT = 'SELECT'
  TYPE_CHECKBOX = 'CHECKBOX'
  TYPE_RADIO = 'RADIO'
  TYPE_DATE = 'DATE'
end
