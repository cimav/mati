class Permission < ApplicationRecord
  belongs_to :agent, optional: true
  belongs_to :removed_by_user, :foreign_key => "removed_by", :class_name => "Person"
  belongs_to :person, optional: true
  belongs_to :item, optional: true
  has_many :activity_logs, as: :element

  ACTIVE = 1
  REMOVED = 2
  
end
