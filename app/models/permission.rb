class Permission < ApplicationRecord
  belongs_to :agent, optional: true
  belongs_to :person, optional: true
  belongs_to :item, optional: true
  has_many :activity_logs, as: :element

  ACTIVE = 1
  REMOVED = 2
  
end
