class Item < ApplicationRecord

  
  belongs_to :item_type
  belongs_to :department
  belongs_to :location
  belongs_to :user, :foreign_key => "used_by", :class_name => "Person"
  belongs_to :agent, :foreign_key => "managed_by", :class_name => "Agent"
  has_many :item_data

  has_many :relationship_children, :foreign_key => "parent_id", :class_name => "ItemRelationship"
  has_many :relationship_parents, :foreign_key => "child_id", :class_name => "ItemRelationship"


  has_many :activity_logs, as: :element


  IMPACT_LOW    = 1
  IMPACT_MEDIUM = 2
  IMPACT_HIGH   = 3

  IMPACT = {
    IMPACT_LOW    => 'Bajo',
    IMPACT_MEDIUM => 'Medio',
    IMPACT_HIGH   => 'Alto'
  }
end
