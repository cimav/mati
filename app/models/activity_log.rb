class ActivityLog < ApplicationRecord
  belongs_to :element, :polymorphic => true
  belongs_to :agent
end
