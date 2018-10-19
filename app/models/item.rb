class Item < ApplicationRecord

  
  belongs_to :item_type
  belongs_to :department
  belongs_to :location
  belongs_to :used_by, :foreign_key => "used_by", :class_name => "People"
  belongs_to :managed_by, :foreign_key => "managed_by", :class_name => "Agent"

  IMPACT_LOW    = 1
  IMPACT_MEDIUM = 2
  IMPACT_HIGH   = 3

  IMPACT = {
    IMPACT_LOW    => 'Bajo',
    IMPACT_MEDIUM => 'Medio',
    IMPACT_HIGH   => 'Alto'
  }
end
